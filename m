Return-Path: <linux-kernel+bounces-449054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04349F4925
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3851891F00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D41DFE0F;
	Tue, 17 Dec 2024 10:46:01 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F241DDC1E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432361; cv=none; b=LqV0MmQWwAC3KXjNZAw5zbsnSU5YaMJ6pq0fY3EqGwvsDpDbgJkyD/q+Cp4YNp9Ko7Ype+N4JymZHd8DHsLp5pT2Atxo67SSZAaBMImXORHQnlspIG8OMEL3w4mk2oRU+YN7/+qaozzLSlMpB5uzFR0yyl6/6jmA/CV8+G6qZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432361; c=relaxed/simple;
	bh=L6D9ThR9H0ZEoKua9QPgH/pmsr8ctmAzmci9EKf/Ih0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcWhDb+EtKpqbsv1CKnwUET27n+9kUeSL100cDt7cGLMW8YBiQ+iPW+boBFBMrU9SSm1JSoQfarXkYtKe48qGNktU4VgB6+KY3dGCzYUNQZt7XziVCBeLCfdBpIHuGb+cf0VRc4bL6JgtbW2hUg2M3QSCeDMlyvZwY9nKtppuF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.172])
	by sina.com (10.185.250.24) with ESMTP
	id 67615656000020A7; Tue, 17 Dec 2024 18:45:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8724010748373
X-SMAIL-UIID: A2F155B4F61B46D7A5ACD1A274243AFE-20241217-184548-1
From: Hillf Danton <hdanton@sina.com>
To: Liju-clr Chen <liju-clr.chen@mediatek.com>,
	Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 23/25] virt: geniezone: Add support for guest VM CPU idle
Date: Tue, 17 Dec 2024 18:45:34 +0800
Message-ID: <20241217104535.167-1-hdanton@sina.com>
In-Reply-To: <20241114100802.4116-24-liju-clr.chen@mediatek.com>
References: <20241114100802.4116-1-liju-clr.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 Nov 2024 18:08:00 +0800
> +/**
> + * gzvm_vcpu_wakeup_all - wakes up all vCPUs associated with the specified
> + * gzvm.
> + * @gzvm: Pointer to gzvm structure.
> + */
> +void gzvm_vcpu_wakeup_all(struct gzvm *gzvm)
> +{
> +	for (int i = 0; i < GZVM_MAX_VCPUS; i++) {
> +		if (gzvm->vcpus[i]) {
> +			gzvm->vcpus[i]->idle_events.virtio_irq += 1;
> +			rcuwait_wake_up(&gzvm->vcpus[i]->wait);
> +		}
> +	}
> +}
> +
>  static enum hrtimer_restart gzvm_vtimer_expire(struct hrtimer *hrt)
>  {
> +	struct gzvm_vcpu *vcpu;
> +
> +	vcpu = container_of(hrt, struct gzvm_vcpu, gzvm_vtimer);
> +
> +	gzvm_vcpu_wakeup_all(vcpu->gzvm);
> +
Given vcpu, what sense could thunder herd make?

>  	return HRTIMER_NORESTART;
>  }

