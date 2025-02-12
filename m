Return-Path: <linux-kernel+bounces-511203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7517A32799
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469257A16F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2CA20E324;
	Wed, 12 Feb 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUTnMABK"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044820AF89
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368414; cv=none; b=k+svhNWOwoo0GwYwYsoyx1NgQdHbAvTezRRomIzEpg0nX3LgaD8sTuUqs1oQ2QBLr3Hcvw/W7nlb/TxQ/6Ck9hcTAF4gkk7nD+7FLIMbuIqHpKIEfMPXx3nzh44sTp68xU0e3h1awl253/dIHfVldUBB52FB4UE4NaV8XgP2ZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368414; c=relaxed/simple;
	bh=NS26Wx8D1xzEYNZaDqn5VSODO2OM/RCGMmVhHQ7LeuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QqVn+BiBQ3paIExvxnCMPw88O+ERNkNKp26lstZa+Z2Ng1QxguISjYuocNC5gTIw0jqFz9YqhWsUg4R+oAGOx24VX7ztfU2gNUN/njUIvDkvHERm26E1SnExLt9h2I/BLVbtq1V82309A6xStMd2uXM6Gk3dKKBSJqyx+c8ut3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUTnMABK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa3fd30d61so10111897a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739368412; x=1739973212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/EzA4gAzllNksMJ0DilYHYamRrSZ5T/I4bo3EXOnpg=;
        b=dUTnMABKbSsp/Ol9bq8sF/etucVnSmde63ia3aU7l3/JzEyY5F7INtvO6R9UV0wMeU
         3/34TEpQW5FF4zgnu5LKw+gYQGyYfyhIeNIEryp4h1n4m6IA20uh3frMIDzDXdOjV5EI
         xTjrNj8rNZD5H9feBYy5mve0qv7QcEq616XaaeMbNjaNArGktzdrNx7rssTjaOdROq1O
         71tUtMEB7ps3wKn3ouysfCKEVp1fTfLmcgS6er6HjEfRNMS/3Ibsrhkf1mpyf8LKeB0e
         AGSuv37/i/wv2hoHPGew8BXCr4pSeJP7idIgJG+pK+t+9Pr2zBQhWsAAsPznmWZCtl0J
         sRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368412; x=1739973212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/EzA4gAzllNksMJ0DilYHYamRrSZ5T/I4bo3EXOnpg=;
        b=THuzMzEGxf/VZozFNDTzm8eOUMm9KEAH5mXVFvq9i1sleqe1v72rPUG+brXXY10ypr
         KrIUr+x6DNt+zc3tmZzpIvappgbhbIfTzRDQjUVvlCVC13eBsSkwz/8wLSgHmZL0qDl7
         RISjmCq1RzV1kCzhxMg8LWgxN4+P3C7bZG4PBI0mNNPWEbuuegVUJkpY7vlMxlsvE1dK
         dKAo8fNsbRHEzRl30FNfr1m19+tL9l5IuRCrh0rQBzyQiHhVY5pol+hbbA9X+O3vH4AM
         LspXsqBLAlOlPYX27c3UBLWrO/6spHlz2ggqw+4e+vUhv5VUGK2AVv/HM8P6iiUXLDu3
         yzEg==
X-Forwarded-Encrypted: i=1; AJvYcCWXrx1VLDaZuuy71bI3XtY7pKwxkGAbTc8UkRzzWh8GVF55TrzpXiEvfUjTj0uxq2BaxRg6FYAMayMBBR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0l13PZq6/TuiN7x0NoUJcWtx8WlIVWszgQcHNdrZHaPiPGyy
	Wx0pJaCRx7qUpugzWHy4JjUhvVB0RbDzFfGrWO97HZyllwB2HYC5/uR8Pb2A9LWC/WQVMla8uBv
	APA==
X-Google-Smtp-Source: AGHT+IFYe3T9Oxuy4agESLPo42TBd2uH5YGxB7YW+51uoarC7Q4NcOtA9s3UjgcR+LLlG5QWXJnoYitI/cw=
X-Received: from pfbfa4.prod.google.com ([2002:a05:6a00:2d04:b0:731:43c2:88e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca1:b0:730:98ef:30b5
 with SMTP id d2e1a72fcca58-7322c570c02mr4336027b3a.5.1739368412057; Wed, 12
 Feb 2025 05:53:32 -0800 (PST)
Date: Wed, 12 Feb 2025 05:53:30 -0800
In-Reply-To: <4b23f7c7-b5e6-41c9-bcae-bd1686b801a6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211025442.3071607-1-binbin.wu@linux.intel.com>
 <20250211025442.3071607-7-binbin.wu@linux.intel.com> <Z6vo5sRyXTbtYSev@google.com>
 <4b23f7c7-b5e6-41c9-bcae-bd1686b801a6@linux.intel.com>
Message-ID: <Z6yn2mNYSkhlwtKd@google.com>
Subject: Re: [PATCH v2 6/8] KVM: TDX: Handle TDG.VP.VMCALL<ReportFatalError>
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: xiaoyao.li@intel.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kai.huang@intel.com, adrian.hunter@intel.com, 
	reinette.chatre@intel.com, tony.lindgren@intel.com, isaku.yamahata@intel.com, 
	yan.y.zhao@intel.com, chao.gao@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 12, 2025, Binbin Wu wrote:
> On 2/12/2025 8:18 AM, Sean Christopherson wrote:
> > On Tue, Feb 11, 2025, Binbin Wu wrote:
> > the information is quite useless because userspace doesn't have reg_mask
> > and so can't know what's in data[4], data[5], etc...  And I won't be the
> > least bit surprised if guests deviate from the GHCI.
> 
> But it also confuses userspace if guests uses special protocol to pass
> information other than ASCII byte stream.

Yes, but only if userspace and the guest aren't in cahoots.  There are use cases
where the VMM and the VM are managed/owned by the same entity.

