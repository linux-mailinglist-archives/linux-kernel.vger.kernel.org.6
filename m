Return-Path: <linux-kernel+bounces-272292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5C9459BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAEDB217EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F56A1BE878;
	Fri,  2 Aug 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dmg769Yq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yumg/vIf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECAF28FD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586600; cv=none; b=e9KT78bodUtuq3WCgkLxyatq+Vexhfea78AzrGvsmUh4xrBlInUn8K2My7MwinZrKaweytDk3iGzu8ICVLoxy+d+s/3Wl6lIAg30iaCIdbJeaWhcPJbbE73pQtjmC1duXQoDQJDD/d9qO/3xTZIrYL725F4Fzfj4mv6+2ibmXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586600; c=relaxed/simple;
	bh=gdeNWR8soxz4eeib2K6453khUtwZS36+7WrrQpUi+9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K2+DokkgKxIxBN9GL5eGYWHS4CNivXdjX/oJhcOKan8Z6aiwe1hW+Nx2Dh4d0QVlGF2CeSCrMLPJ8XdGHnP6t2wyMlFb23oU8zTaGPYJ+1iVNOhMM8qJaYA++JrTEY7DKzUj+7c+dIk3MUgri578ZTTmfRBenTgTWaO1fPvOXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dmg769Yq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yumg/vIf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722586597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Evu9e0koJQhJz9/8SBcclE+brOgY89I/UofDCj+XEB0=;
	b=Dmg769YqCcrrxhMzDWSdAZm2idlYy1gSeebDlaTBTz7kbkksamklMVZYNju2y121MHcQEt
	cb/nDLJUj2Pp5Ww7Bjj4dMZZW8DxDaajqaepxPR+sdbzBjkv/fvNDv3HGCtEXd7uu3gdc0
	OD4y+cD3P5zQ24L2jck4nqt/AxDk7spUHZuGFQKusWrRb4Vg7fPL1IHZYizKPNtWJ0tBqI
	xDUL4ibqP0t33Asxx6xJZDGY8qJSn6FyZTezhRcv6rnU78enUD3zrAMF/EicVWkPc47nf7
	fLs9jWUgfdcyV9Mi0ALMpDyYIgY17KNMCmqSzUgPVyKXYmTiH6nwdU2BZyLj8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722586597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Evu9e0koJQhJz9/8SBcclE+brOgY89I/UofDCj+XEB0=;
	b=Yumg/vIfqnqpczcCjZt0hbsUhZv7LJlpKqDQQTQDhoIftAtV9P/2fpBboyCQIiNdr5ugDP
	3fD2FdemzbmrVPDg==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 linux-mm@kvack.org, keith.lucas@oracle.com, jeffxu@chromium.org,
 rick.p.edgecombe@intel.com, jorgelo@chromium.org, keescook@chromium.org,
 sroettger@google.com, jannh@google.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH v8 5/5] selftests/mm: Add new testcases for pkeys
In-Reply-To: <20240802061318.2140081-6-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
 <20240802061318.2140081-6-aruna.ramakrishna@oracle.com>
Date: Fri, 02 Aug 2024 10:16:36 +0200
Message-ID: <87y15f1grf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 02 2024 at 06:13, Aruna Ramakrishna wrote:
>  
>  ifneq (,$(findstring $(ARCH),powerpc))
>  TEST_GEN_FILES += protection_keys
> +TEST_GEN_FILES += pkey_sighandler_tests

That can't work because the raw_syscall() inline won't do anything on
non x86, right?

No need to resend. I removed it already and added a build error into
raw_syscall() just in case that someone tries to enable it.

Thanks,

        tglx

