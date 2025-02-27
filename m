Return-Path: <linux-kernel+bounces-536537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DDBA4813F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1583179D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E322309A8;
	Thu, 27 Feb 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh8lVoVC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7E1B3725
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665363; cv=none; b=VTzDyEG68PEKVEquxSsFWCF3Pr5WZpTMH5O+ANhl+j+cPdjdP5h+1rqMtsMhvBwes9OKDU6R6Hhs0jkHjiuASoE84xn4LfbgavdjmP903Ub5mlgdfaR5hGsAec1u1i+4ct5E4uTRbx2PuVI4ytTSPRZRqOn7yatC0wIoYRD8RhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665363; c=relaxed/simple;
	bh=1B+u+Ey5NfQ1W0uCS+LMIBClhgnqJlWh6mxIH5g4TSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibKWlUrHnAaFzwPdd2UBBHm69M6Gvetn2d2MblraM5WWhw81LG/Dn1zReESMzHkkshQSd79y/7lEPyd3fAeu/t82IQwEv/bE2iBuIoiYQxI+gD9YpJmU4549sF68rltMUl8pZA6asHm8j1QNis+MISkwhbWwFILc8aRB4MzdTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh8lVoVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2FC4CEE8;
	Thu, 27 Feb 2025 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740665363;
	bh=1B+u+Ey5NfQ1W0uCS+LMIBClhgnqJlWh6mxIH5g4TSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vh8lVoVCZd6pRiJGuoS/yoFS7Q3R/icxBjSSFfwtFWRREgIyLlIdMqboOSdlf85ok
	 bjTZr43wPyiILHTEg5feq8/1wmgqy0e0dRVJItCTvUySG9dqeku5gM7h3UfhfEn8Iz
	 CP2tTZV2c/QvgnHej4mI1NSJuE6BNiWoyXL0XwMQeH9AhtwcjHABp9aT8sa8zsVmtw
	 o0I1fBOecfdtBFlsQhaZBLFm8htCmm31DJDWCFo1DvAZJ+8l2JpNhg1rCpsEXLbMKW
	 Qn6zrINP98oy88dehNCiPIZzERrplPgKNn2BrwjoCeC04AgzL1a7S0ag27rOiizmlr
	 tJR+5dZYY658g==
Date: Thu, 27 Feb 2025 15:09:12 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sysctl: simplify the min/max boundary check
Message-ID: <niuy3o2sk54mycvircqoykvj4pwo5ds4dfehzpmuehuwpznx3u@u3fhw6656xpk>
References: <20250105152853.211037-1-wen.yang@linux.dev>
 <ce2na5wzbkpvrh4tccmrfwi5hukwjnrpkhnggdfgce7ccs5rvq@w2c76uttfxq3>
 <58da9dcb-a4ea-4d23-a7e5-b7f92293831a@linux.dev>
 <i5h3sxl34d5pddluwxfhlumkt5fatin3rsqbwpfcm2rceg46ix@w3c2l6ntu2ye>
 <875xm5o0tx.fsf@email.froward.int.ebiederm.org>
 <87o6zxmlha.fsf@email.froward.int.ebiederm.org>
 <ov6x26vw4rq5ekz4fy2t23xbtkh2dkkrfrkzp7dvkhy2djm4vl@2b7batukhrbm>
 <875xm0gn60.fsf@email.froward.int.ebiederm.org>
 <e861fc51-f244-4645-af72-56416a422060@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e861fc51-f244-4645-af72-56416a422060@linux.dev>

On Thu, Jan 30, 2025 at 10:32:14PM +0800, Wen Yang wrote:
> 
> 
> On 2025/1/28 01:51, Eric W. Biederman wrote:
> > Joel Granados <joel.granados@kernel.org> writes:
> > 
...
> > that use extra1 or extra2 for something besides min and max.  Then
> > remove extra1 and extra2.  At the end it is simpler and requires the
> > same or a little less space.
> > 
> > That was and remains my suggestion.
> > 
> 
> Thanks for your valuable suggestions. We will continue to move forward along
> it and need your more guidance.
> 
> But there are also a few codes that do take the extra{1, 2} as pointers, for
> example:
> 
> int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>                           proc_handler *handler)
> {
> ...
>         for (i = 0; i < NEIGH_VAR_GC_INTERVAL; i++) {
>                 t->neigh_vars[i].data += (long) p;
>                 t->neigh_vars[i].extra1 = dev;
>                 t->neigh_vars[i].extra2 = p;
>         }
> ...
> }
> 
> static void neigh_proc_update(const struct ctl_table *ctl, int write)
> {
>         struct net_device *dev = ctl->extra1;
>         struct neigh_parms *p = ctl->extra2;
>         struct net *net = neigh_parms_net(p);
>         int index = (int *) ctl->data - p->data;
> ...
> }
> 
> 
> So could we modify it in this way to make it compatible with these two
> situations:
> 
> @@ -137,8 +137,16 @@ struct ctl_table {
>         umode_t mode;
>         proc_handler *proc_handler;     /* Callback for text formatting */
>         struct ctl_table_poll *poll;
> -       void *extra1;
> -       void *extra2;
> +       union {
> +               struct {
> +                       void *extra1;
> +                       void *extra2;
> +               };
> +               struct {
> +                       unsigned long min;
> +                       unsigned long max;
> +               };
> +       };
>  } __randomize_layout;

I'm still not convinced that a union is the best way out of this. I have
postponed reviewing this for several weeks, but I'm slowly coming back
to it.

Thx for your suggestion

Best


-- 

Joel Granados

