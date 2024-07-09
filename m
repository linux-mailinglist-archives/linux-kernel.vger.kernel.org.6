Return-Path: <linux-kernel+bounces-246759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754F492C640
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FC8283207
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720BA155A56;
	Tue,  9 Jul 2024 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcPA1k1A"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C314F9C5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564286; cv=none; b=pHEb8omiG/dfNv2BecqmD31imFhz0IHwTMsVdsBam61qUUcx2OaCVsBBiNc5BB0vBFtGehiig9v0OcV65izZpcIXEx7r0JA3/WL0KvqAaH1gGyuR0d4zHECoMphLyXqeaMbaaocTqocJ+pyc+1AS7n2hA5SWUh0SBDyvMseOCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564286; c=relaxed/simple;
	bh=I7gSWmVV4vXFUCoNUrEOc38mqTWFBsiO3LkxG+qn4Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYFr3e0gQsSk/tbeesIsgWg8qAvh+KDBObKY+uRtPSYtZB2GoHfAQtBln67dq4rWmpRGoHoCi5eEJ1U8ABMU3a/SDV9DDNHle++L3DhBGCq7PD4Tep6n+5xzDWeNl5JcsmFF2UKv68WN4b8wmj68xBIZvXIfwQqcx0T7p3PVjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcPA1k1A; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-71871d5e087so3931995a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720564284; x=1721169084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk2gPv74LRKikOK4OISmF2vsurbf0ItnRmMMelfOtc8=;
        b=PcPA1k1AKOiIIMtd8z5ZVPhtCC26RyJPepBMnPV8QguJNx06Pqg4/XB9HeViTTR/JV
         FDEUYySE4s8DxvQUi/cLi7KP24RHjWllMpVvJ3V5oCDZaZ+h1Y8Xte5dE/RQw6k8JELC
         GMBWUmECJXlJ5Q09QzQNCEqEnsql/lA8LBnvyXqjOE9mc24zKaz6QxnGpYrBP6JPyTXG
         lqpeVPc5BM1UZI/kvu1eaGXyBmwhERYfNpGIqkKsy2JxiGNwrxzorG1ePXv2udvvlETo
         Knicmg7JjtAdLDNeEv37y8Tu6AT4tX5ZMYaKh6fp2sH45AxJv33XHrjB2e0C7+sR4A25
         H+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720564284; x=1721169084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bk2gPv74LRKikOK4OISmF2vsurbf0ItnRmMMelfOtc8=;
        b=mPnkZ3VaqypF8CoVA5xxZz1YoDAGXyyGutzOlhp36qyGApjPkLOv5Bk1ctcHaZN3mQ
         fMeiq5gzKTIIKuK0dQeRAU5WKXiEu3zUH5goQaEU0IjkMDrY/Q/gkk83wGA9zCuOyvp9
         U6Pj4Ow/YzBTPB2LUOAUypQSB9jcZZi/8l8Udb2broIqMP4dMwV0YyEtfSIF946SPu3D
         IMfB/n5TrG2YsoCWwhU2r3giLT7/eyvs17ukzald/6EUpn53A8kVAifmvd7Vzzd6iifN
         rgppklLeS1FCcdX3W43HR2IRKXSLShpQavjrqNoxTltZYBahvZvdDqftQ3rEKUIIU3RX
         bjRQ==
X-Gm-Message-State: AOJu0Yz9toZQBNiAm4Knfgqb57G4PlDpmi6YYaGs4MEWTH6ktHydheQV
	FSjLaqxzgdzPgqZVhDDHa+Q8nDjfrzPRrDDFEQZB1iAtSyieqedo7sNL2Q==
X-Google-Smtp-Source: AGHT+IFPXXUN5eOa5yAAQ9Ixj1XAgbGOHWWRt7sGALkqAIcrCkqIiPbdf1aCItnofjRXq7f2HHfUFQ==
X-Received: by 2002:a05:6a20:da95:b0:1be:c057:ea12 with SMTP id adf61e73a8af0-1c29822114dmr4120753637.14.1720564283566;
        Tue, 09 Jul 2024 15:31:23 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c0a94sm2362953b3a.62.2024.07.09.15.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:31:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Jul 2024 12:31:21 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com
Subject: Re: [PATCHSET sched_ext/for-6.11] sched_ext: Fix
 scx_bpf_reenqueue_local()
Message-ID: <Zo26OZ6cXppKd23d@slm.duckdns.org>
References: <20240709211001.1198145-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709211001.1198145-1-tj@kernel.org>

On Tue, Jul 09, 2024 at 11:09:41AM -1000, Tejun Heo wrote:
> Fix scx_bpf_reenqueue_local()'s misbehaviors in two cases:
> 
> - when SCX_ENQ_HEAD is used to dispatch a re-enqueued task back to the same
>   local DSQ.
> 
> - when the CPU is being preempted by stop_task for task migration.
> 
> This patchset contains the following two patches:
> 
>  0001-sched_ext-Reimplement-scx_bpf_reenqueue_local.patch
>  0002-sched_ext-Make-scx_bpf_reenqueue_local-skip-tasks-th.patch

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

