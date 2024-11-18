Return-Path: <linux-kernel+bounces-413440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579AC9D191D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB0FB21524
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612781E570B;
	Mon, 18 Nov 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh+8P1jN"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66025208A5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958993; cv=none; b=oRRIAiFT0A4g7Stto8jzQNlh5Bn7jotRC9vobk32qn+3h0WsweNU2mA0Qv86/6dRp7YFRDD33lzi3cuEKDPQHBsLqTs/4hB5rHmjiqpRDzrPPv162p77sX+vgLyNptHWi534bteCHh0RvIDzE9vV2hNzyH8/o5n0sfG1gvVpb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958993; c=relaxed/simple;
	bh=njUdAZfa8lANEQjq5X2bXL1MLYtDgdVYTs2FIIEDkC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/HHVcC58KscVpEux4jWuFdZnohhwHJ4L3Ft1xU52M8Y7jk01hWF4TRjJWsSFb1JFNT0/xbcHObfEy/1horXfesYO8KR87zk6AHqN4kYuNZNURxoEY501hE6J0PC5As8p2ULO5PMegzroC8aqW295kFLj5cuHOMhObVwJ5KdW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh+8P1jN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso1799574a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731958992; x=1732563792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ExFwATEncSH94NRCrPZ0WpSOV3S/YNTZKY5WGYHB6g=;
        b=Gh+8P1jNhgrBgqnwINHSnPxnzloLYX5n30gXXeDNYGONC6GMV12MmO6ceHUhekLB9a
         lXRxHdsTPwy3WJs7qMifRVJiBZ2AuvQrUTdDKReTO0RlbMcqcsJ4vLH9NKdfnP9bHWEI
         4z6i7mzxsizsqv4QPzDXsbKQtJB6PvS9NCms4+KuJ+1k9TOwFwv5cbgRB+3aRxh+SppM
         LhDrCdwgXoD8FRoHy5QuhyggQ7jtjitZWuvIBVl2dLyluZ/iPiFbrJBDMc8S1CxyzY14
         tAhgrrW/MgOMuIMn2KHTkGNmUf5gwgxb7ifGnG8aabC/g07GTyO9i6g6mc89AN0XGAu/
         V8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958992; x=1732563792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ExFwATEncSH94NRCrPZ0WpSOV3S/YNTZKY5WGYHB6g=;
        b=ABj+WUMNYcnj5TcLwlrPIaVwB9o6QqmHOAsuYQ+9+GPPvRzosvZeuz7PBwp9ZfcXhM
         RItZitqvPpP6UtNKhw3RWESEnV8Z8UMxGhcs1LELwCCI0kETDtoAxlm5m5yevk+BkU4J
         IMqh0Jukc741v4OkGlYqqQsrH0L64SdxmL5iTSnMJw0Vqocaxy7IzmwAL0lquRDy7pBj
         KB4Xvr4wteTo+YmGh2cnWEoP5Ea7u6TtyInWfGP+RGvesY3gNGqF1cTA/gRblieoxkeq
         FNrPrLsXmGAKhCJNOVku1jCeIUR8hixqO30VddKbdRmvjrr0K47Yn7F56tiiOaEU2uE1
         JrXw==
X-Forwarded-Encrypted: i=1; AJvYcCVwzV3IZ36sGjlzapMC7lyFCF3WrHah4FbYi+Fle/dOv0XqqipWCD1mpIo/Q0nPgpGjydqnmCT5Kn3IH2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAywrzOEFbQgbcDxKKBG/MImiHqg+sGugmR3Qzu4SwyQwiFYF
	/Fz+XfbNFBtVUDoUVyHhRCJ6eiq5KaUPsgmqZshH/m8Jm1V7PfFZ
X-Google-Smtp-Source: AGHT+IEWeeVBywxK6R0qaTKR+HyfDXCnsSsDj4PqaWlNH59kYyxcD+QEVK2SyWz/7v5Px4wGFtheMw==
X-Received: by 2002:a17:90b:278c:b0:2ea:88d4:a0cb with SMTP id 98e67ed59e1d1-2ea88d4a53cmr4193494a91.16.1731958990671;
        Mon, 18 Nov 2024 11:43:10 -0800 (PST)
Received: from desktop ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea90cdfa8dsm1557734a91.51.2024.11.18.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 11:43:10 -0800 (PST)
Date: Mon, 18 Nov 2024 11:43:07 -0800
From: "Ragavendra B.N." <ragavendra.bn@gmail.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, ashish.kalra@amd.com,
	tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Message-ID: <ZzuYy9KHwlLa9HLY@desktop>
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com>
 <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
 <ZzemwFBfEIgFhrD-@desktop>
 <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
 <c7a9748e-aead-b252-dd29-48dd0d2da9be@amd.com>
 <30558bc8-c22c-1ce1-f59a-66c057fdd06f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30558bc8-c22c-1ce1-f59a-66c057fdd06f@amd.com>

On Mon, Nov 18, 2024 at 08:53:04AM -0600, Tom Lendacky wrote:
> On 11/18/24 08:44, Tom Lendacky wrote:
> > On 11/15/24 16:55, Ard Biesheuvel wrote:
> >> On Fri, 15 Nov 2024 at 20:53, Ragavendra B.N. <ragavendra.bn@gmail.com> wrote:
> >>>
> >>> On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
> >>>> On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
> >>>>>
> >>>>>
> >>>>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
> >>>>>
> >>>>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
> >>>>>> it was not initialized.
> >>>>>>
> >>>>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> >>>>>
> >>>>> This 'Fixes' tag looks bogus.
> >>>>>
> >>>>
> >>>> So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
> >>> Thank you very much for your response. I am relatively new to kernel development.
> >>>
> >>> I know we can use kmalloc for memory allocation. Please advice.
> >>>
> >>> struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);
> >>>
> >>> I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.
> >>>
> >>
> >> The code is fine as is. Let's end this thread here, shall we?
> > 
> > I was assuming he got some kind of warning from some compiler options or
> > a static checker. Is that the case Ragavendra?
> > 
> > When I look at the code, it is possible for ctxt->fi.error_code to be
> > left uninitialized. The simple fix is to just initialize ctxt as:
> > 
> > 	struct es_em_ctxt ctxt = {};
> 
> Although to cover all cases now and going forwared, the es_em_ctxt fi
> member should just be zeroed in verify_exception_info() when
> ES_EXCEPTION is going to be returned.
> 
> Thanks,
> Tom
> 
> > 
> > Thanks,
> > Tom

Yes Tom, that is exactly the reason I worked on it the first place. The issue was reported by the Coverity tool.

I can send the below fix if that is fine.
> > 	struct es_em_ctxt ctxt = {};

For the es_em_ctxt fi member to be zeroed, I can go ahead and assign 0 to all the three long members like below in verify_exception_info()


	if (info & SVM_EVTINJ_VALID_ERR) {
		ctxt->fi.error_code = info >> 32;
	} else {
		ctxt->fi.error_code = 0;
		ctxt->fi.vector = 0;
		ctxt->fi.cr2 = 0;

	}

return ES_EXCEPTION;

Thanks,
Ragavendra N.

