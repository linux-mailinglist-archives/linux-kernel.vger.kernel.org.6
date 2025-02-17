Return-Path: <linux-kernel+bounces-517384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984CFA3801B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A46B1687FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EA8216E14;
	Mon, 17 Feb 2025 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojEc8Eh3"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC923CE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788025; cv=none; b=nQB//A3BwqBkmUFCdWxVxIpRwnqgUhTx+9+oYhJYbrFwhW/Y8KRRFWUrQlOnHGFaA7zRQPxLGv2Uure+LdxIUTra++1gUi0szsHts1BZFyZ0vMhUP7L+1e98kkM6MFX0EhM/yCPSXc1OaxM5jF3iH3lWkgwHthfHH17tp2avgAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788025; c=relaxed/simple;
	bh=9k3Ley5on6cNS3Um6E7fX7FSbKjsfoF3+qaejyNgr8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Av9IhPTl6wpfieR9JR5snusokWr4lHWGQAYSpqCa1EqGOsT6ArLiFGsQ8T75i/T3tFklY62tYSMNgXDtRBfyfFHmb1CE5H/QLRKpGKpcPX+Wi5gyrfacIeiXltUsCZ4iE9vg9jwd4TYyTR87FsgOpquQm3J8FMqZ3zaGu5tOQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojEc8Eh3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7641493a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739788022; x=1740392822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k3Ley5on6cNS3Um6E7fX7FSbKjsfoF3+qaejyNgr8E=;
        b=ojEc8Eh3sW9bRQsx7XVj8s74mPFoVsBbPj8bMb9Nb8LznBcXe/l4E03YzsLDfIP5Ok
         moE6QykfPVp/7T+7bZombbz7QaZRUKuu6vk89cRSFtHL1alJPcMTmWV2zvjnHdU5l1pk
         glsAZNb3rw9T5jlv59kt7WEVzPh60iEh8sIWyA3I6BKuQcV/rTNfXo4WxMYS8WrO/IES
         d7rPou/f4S7GEKMqcMHQ85fJkmdyG0ev78iczSSYMP1GpTSIcFx/Z0RXfrwPW1h2Yq7P
         3NQx2z2voNYpiyuDEtQbR9I08QBOPw6H17domXG+BuxXw9zYD/ro2QDpQ5MLNcfqEPWT
         EXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739788022; x=1740392822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k3Ley5on6cNS3Um6E7fX7FSbKjsfoF3+qaejyNgr8E=;
        b=SlQbeRuXMWNWvNV65wkwxWQyDYW9pT1r3EIxoQntuCV86IGXz3lBA+T6QmCz/2pCP3
         Y2slSKv3AXzscYdqNTHp1zz29emuoYdiPPitdCgLpXCW9JuVyIMcRzBBWIZB+ljaSii+
         TQ/Da2i4rcNVJcgw0d2wOXLXw0HFanCJqpSvIV3j/fQ91HMTS8ZbEckxx3oGkZueU5M+
         Oxk7KATq6yOKam1XbHxNS4QnnYC1lsSzaPI8TcHjv8ShbbVh38tZIoozCFmfLMPmmF6L
         EzPRdFvQ6y3vI7UFXxbE5aILG2pLScyjYrxZ6mhIK9IhVmC540ZMsAL3U7MFwAfFMHWu
         WzJg==
X-Forwarded-Encrypted: i=1; AJvYcCVdrsI7ckmvpEe/TGXmwkVnqMFIi3UURazhPTndcYSRt5ZEfUe1ayRpARDe+PVIjl/M3AuO2BCVrLCgI5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLngMzXV2tafEH6ZJ8gWXdpychfrRIXa41etho9/ytdI8st204
	hlrXW/FIJPdoU8SSOgSQdbRjUtjKTqgxInwCBjaIc4mJpzXyTi1QOPtvNWavMy1CtAYYTm++Y3A
	/tp25fviqA+tck5nbPBNsqWEWwk3otlgP6iYs
X-Gm-Gg: ASbGnctEg9myUNFCvuzg8KmRH6VSyi+vITaiRjHnKQ+hhL0hDlc8J5fSZLz2ONlax0R
	GlgZJAic0un7350SHINTKpW4FpaoYTV0s0lykJBcMRko7Rpcd+VYg+PD/7HHtdc4YgYRA+qqfVl
	PvyrQmudG4kQXtKQQ3a5zAfzWyfVI=
X-Google-Smtp-Source: AGHT+IGg1IvKUUc/p89hI5JmJHNwGjCIidYUwflNrBdFIe9/jBuy8aomXpodWq0ngM1ox2M+sGMDDJ33W91g3uOhF/M=
X-Received: by 2002:a17:907:9494:b0:aba:6385:b46d with SMTP id
 a640c23a62f3a-abb711c8145mr868876766b.50.1739788021652; Mon, 17 Feb 2025
 02:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737577229.git.babu.moger@amd.com> <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com> <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com> <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
In-Reply-To: <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 17 Feb 2025 11:26:50 +0100
X-Gm-Features: AWEUYZkJWWlGFJQHM3ION9s69WbN6z7O8hPgk5lTi1q7GZyVgca9f_VULlmwWfM
Message-ID: <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>, 
	corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org, 
	hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org, 
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com, 
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com, 
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com, 
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com, 
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com, 
	mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maciej.wieczor-retman@intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Fri, Feb 14, 2025 at 8:18=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Babu,
>
> On 2/14/25 10:31 AM, Moger, Babu wrote:
> > On 2/14/2025 12:26 AM, Reinette Chatre wrote:
> >> On 2/13/25 9:37 AM, Dave Martin wrote:
> >>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
> >>>> On 2/12/25 9:46 AM, Dave Martin wrote:
> >>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>
> (quoting relevant parts with goal to focus discussion on new possible syn=
tax)
>
> >>>> I see the support for MPAM events distinct from the support of assig=
nable counters.
> >>>> Once the MPAM events are sorted, I think that they can be assigned w=
ith existing interface.
> >>>> Please help me understand if you see it differently.
> >>>>
> >>>> Doing so would need to come up with alphabetical letters for these e=
vents,
> >>>> which seems to be needed for your proposal also? If we use possible =
flags of:
> >>>>
> >>>> mbm_local_read_bytes a
> >>>> mbm_local_write_bytes b
> >>>>
> >>>> Then mbm_assign_control can be used as:
> >>>> # echo '//0=3Dab;1=3Db' >/sys/fs/resctrl/info/L3_MON/mbm_assign_cont=
rol
> >>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
> >>>> <value>
> >>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
> >>>>
> >>>> One issue would be when resctrl needs to support more than 26 events=
 (no more flags available),
> >>>> assuming that upper case would be used for "shared" counters (unless=
 this interface is defined
> >>>> differently and only few uppercase letters used for it). Would this =
be too low of a limit?
>
> As mentioned above, one possible issue with existing interface is that
> it is limited to 26 events (assuming only lower case letters are used). T=
he limit
> is low enough to be of concern.

The events which can be monitored by a single counter on ABMC and MPAM
so far are combinable, so 26 counters per group today means it limits
breaking down MBM traffic for each group 26 ways. If a user complained
that a 26-way breakdown of a group's MBM traffic was limiting their
investigation, I would question whether they know what they're looking
for.

-Peter

