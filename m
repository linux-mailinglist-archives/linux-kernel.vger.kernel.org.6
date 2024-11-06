Return-Path: <linux-kernel+bounces-397953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D99BE2EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70EC1C20A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D221DBB13;
	Wed,  6 Nov 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yq4u9rob"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3731D2784
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886183; cv=none; b=NNgFfuwvjrel5RN5fbE46eSx/POGHUZ1ehTXymT+JIioaWiZ/eLLpSWUCyWSnCPK91ULY5S22VbWruRjqKNu2X9QbpFWuUFZfWcfd5N2EKTxVSTckLLscF9bBg1IXx2Lr81mzYAPeoGJ48eW8XiC/ce6+HtfQN7M2UJuDV2K8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886183; c=relaxed/simple;
	bh=v3BE1AGYgaByqf9TkquWFFQw88soPJOsMWl9K4RwGyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwuzCYOEnUU3esBwzZYTaFbS7yBBZ3UP7RoAriJh8HhE5Bj3izDObaHW4roEofa/kkgMY0I/X35+bty2K8dGmPl12US+LRF8GDpGpUvRr3w37G2F4mEiq7K3++QbXh5xmm+FICRa8M4YQyy2tomhvIC/kjBLN8sL7o1wC5bwibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yq4u9rob; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so758858566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730886180; x=1731490980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3HO8GRS9YoUUFHjEEsBwwX9O0NVuYqbuR4yYdoS3m8=;
        b=yq4u9rob2m3wSYvIAOUh1ITU81dz1cFY3IH++ycXXYiyjuso8JTbsFW6dt3U0Y2DCI
         m/8ghgyFTqj0tgNtL3gcCQ+Unb8VakxQLeBt78jRqyKHDendgKBorTimDWDb1zbTIkQE
         RH9GbQNMcI/RleZlFY5lhY5YCI86SFN9XmOcLG/1bLcIuHK9rtU8AfE5o2eySyI8D8x5
         CXmr5VSIqdnScQE5zgV1+3aDHrhDZOzgpTvv+GiUaoyMaOYN7eGRfFbhOwTQ3G33CRnf
         F/5X2cioqwNuCqDlbAlYiMRXkma1+ExVPemJPGh9Xr3W6vBsiE90zxGqBuhERE8Q6KVV
         NcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886180; x=1731490980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3HO8GRS9YoUUFHjEEsBwwX9O0NVuYqbuR4yYdoS3m8=;
        b=j2q5BHE4tdAVUSEQlQPO0vo7dqPcNN25/3MuxilThiNqLD2sSUCLm3zN/2/4dFe7tG
         M0K76iwcKJ+evTEJDIoLcuX/wctnjS8+GBNh07GK7HvCKDP8SjxDKW3+DmMcIKI9XUm1
         P1Jja+MOPLYEeXeyFTQFl3vT7tvC5lhzmWBfotHBDTATNoOuw4rQhMXTpjmw1LKMtdsL
         1A6vXiIQ/1nCyqwmmnnxCOF9Pq0G/2DsaD6UKA3Nmxg4Ybjqnkjt7ONZSX4n+ShYyN8q
         pXlREVt58YmgWZY60N6pfa/+dSOg0krdoL8tgPYIZmMZV/BkqlL1IbApbTpWNSgjnMGN
         b3pA==
X-Forwarded-Encrypted: i=1; AJvYcCXhbxH6c8B9o/LfWnLtloRVCB+tZ43vogRrBvFZNCT/3bG2BXxm2alOU/34hcNYBrqVtmDjUPeViTZHQZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxfhwD0+5EtrQBl7OuD5aMnkhWaBdcpRbaj90CrCXlWbvvEVrA
	BnbxzOWBLHkxYRpDEMksXyUwcHZk9Cgpjo2oeaZLDMe1pENQFS/J6MrP232siYjrKOh7npNM9ud
	qa7KBnli5bzjH5dLSyvPZzYO4VKg905QGzfW8
X-Google-Smtp-Source: AGHT+IFrsVleYlfA4dc4OmQAE/M66K/idOVdphzkHxHOgz+IgotqdGB+MmG1Kf9ZnyLm6zBWX+6eVZY3UWS0BJKSfvI=
X-Received: by 2002:a17:906:4789:b0:a9a:f84:fefd with SMTP id
 a640c23a62f3a-a9e655b6912mr1710641966b.36.1730886180018; Wed, 06 Nov 2024
 01:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com> <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
 <4e2f31bf-1035-40a6-b16d-081d6e45ead8@intel.com> <SJ1PR11MB6083D1B48E48BBE797ACF21FFC522@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5ec7a1c1-43b1-4c18-9ba5-5cf4c42ba3f1@intel.com>
In-Reply-To: <5ec7a1c1-43b1-4c18-9ba5-5cf4c42ba3f1@intel.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 6 Nov 2024 10:42:49 +0100
Message-ID: <CALPaoCjyAHAkKJAx3FL3Lze2KkWxDWFDaMyNFPRwuh0Y4Vzz2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter reads
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Babu Moger <babu.moger@amd.com>, James Morse <james.morse@arm.com>, 
	Martin Kletzander <nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Reinette,

On Wed, Nov 6, 2024 at 1:13=E2=80=AFAM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> Hi Tony,
>
> On 11/5/24 3:39 PM, Luck, Tony wrote:
> >> I think this change already undoes the motivation for 09909e098113
> >> ("x86/resctrl: Queue mon_event_read() instead of sending an IPI")? As =
you mention in
> >> changelog the goal of that work was to enable resctrl_arch_rmid_read()=
 to sleep.
> >> This change will call resctrl_arch_rmid_read() with preemption disable=
d if
> >> it happens to be called on CPU in monitoring domain. Would that not ca=
use
> >> MPAM monitor count reads from CPU in domain to be a bug?
> >>
> >> Could you please try out this patch with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy=
?
> >
> > How is this all going to look after the split into fs/resctrl and arch/=
* ?
>
> Unclear to me at this point. Peter exposed an issue with current implemen=
tation
> and this needs to be fixed. Since this involves preparatory work that imp=
acts
> systems currently supported we could also consider reverting to original =
behavior
> and go back to drawing board with the preparatory work.
>
> > Is the file system code going to have implementation choices that preve=
nt
> > performance sensitive users like Peter from optimizing monitor event
> > reads by binding the monitor process to a CPU in the right domain
> > to avoid IPI?
>
> Apologies for not clearly stating it but I do agree that there is an issu=
e
> that needs to be fixed.
>
> My response was not intended to be interpreted as a NACK but instead an a=
ttempt
> to engage in discussion by pointing out that the proposed fix may not be =
ideal.
>
> I tried out my own suggestion and indeed when just trying to mount resctr=
l
> on x86 with this patch applied results in:
>         BUG: scheduling while atomic
>
> I do not object to optimizing monitor event reads but the proposed fix
> is not appropriate in its current form.

Yes, I mentioned the atomic sleep issues in my reply to Fenghua. I
expect even the new case I added will have problems on
resctrl_arch_rmid_read() implementations which block, since it would
need to be called with preemption disabled to ensure invocation by a
direct function call stays in the right domain. The last proposed MPAM
resctrl_arch_rmid_read() implementation I saw can return an error when
called in an atomic context, so that means my change would cause slow
counters (i.e., MPAM CSU) to be unreadable when read from the local
domain. (Or totally unreadable on a single-domain machine.)

As a refresher, the original issue that led to this situation was how
an MPAM CSU (cache occupancy) monitor can be installed in response to
a read request. The number of monitors is usually small (or just 1),
so they need to be frequently installed, there can be access issues
depending on what CPU wants to read which domain, and installing a
monitor is a slow operation that requires waiting.

https://lore.kernel.org/lkml/670081d0-b4fc-79c5-68f8-5b3c162b74b9@arm.com/

Thanks,
-Peter

