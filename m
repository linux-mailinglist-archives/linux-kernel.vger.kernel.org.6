Return-Path: <linux-kernel+bounces-414914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A07E9D2F30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBDC1F21DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7831D2207;
	Tue, 19 Nov 2024 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzb5M3DZ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014D15442A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046111; cv=none; b=HsGQl165NEw3sl2Rpjrja2UixnO+H1FAi2+yMTgUeleYrcOC5GiWdAV1Q4HB9pQxE31B3wX/EnqlFo0ifnU//Jcl693UyPWxZ+jYiQynUa1SbWRg8Gr81xA7xYkf8fSBd2uSOeHwBEDjjoRvf6IuplMdt0h9iAzp6YvL4qVx3yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046111; c=relaxed/simple;
	bh=epLsmlz2Z/TW2m8wt3xNrIDCZIx9V1INH1KGverRFA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JM6jQkzszFYjlIjIrsgM59fVeFeWbRpMNVSEEd1Ad5OklLzcTI2W+xNcoxbEFX2IRcD6SZD5XqtvmvAxjtXLKbkuXGKbHF8xIOlQQcGKY0lRBX7TkpXWqLWRZHR1PaYBvtK+GZwv/47jiFeVuZ8bsZC/mWNiVG7LQeYvjvznYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzb5M3DZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7240fa50694so3897808b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732046109; x=1732650909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epLsmlz2Z/TW2m8wt3xNrIDCZIx9V1INH1KGverRFA4=;
        b=Zzb5M3DZcz0clC21RoTOiDNaKqSF0YHZKPDjHIVFyWb2/unrlOjl/AdD0soRs0bEpx
         ZCFtHA7CnnwCm6J3UJE+PIYVr0nly8jGE2yb1cZik0b8vg1Ypm6dgKWyjevhAZ3WCMMa
         ixC61xkrKslTJdHYaJXpifpCIYAXRrNQA9uch6VmrgFrGCN1ZaZVFctgFhmZUjTGsTR8
         aVGNKxbnb27pI3ULFgJK2peIGQltEu4F5PjFQRu7kjVYjLrO1t8iq/uQ0vz8l3eKv/x3
         h9BBwpbD/rQy7d9SeHprW0f+PklP5vkemM/foA93ya2ckMhhz14cHYAnXF4Kf+ly5Ah7
         zr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732046109; x=1732650909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epLsmlz2Z/TW2m8wt3xNrIDCZIx9V1INH1KGverRFA4=;
        b=Wc5fuK5UTEoMDcJXR6N110LSwde7qgpDCM7Hj/BF5si3ldiTuHsfPn4hRlSHWjiuJ1
         ZCEqOEwWK4w5TA4obzrgcQo5KDuuQID5GMHNanL8uM/uj+tRRy/AiB9cynGp4faEkfJi
         5HVIBaH6iL1vqgNfT/JUlLAJvcsHw8DC8yPxEGS8ZdvalRyhgt87/Rc7ROsd+baO1ott
         PsnC0/uZPCsuX027is2DsP6RriwaFB2I6LR+w1QZC7Mhv1galaZ07DTZfOncPaZZQ+0o
         F7j1EJGCUfeCGGnEVwnXxpYR6RT3QHYpKbA679WVld/2pU0ahOXuYVZTh5lmfBZ/GicW
         aanw==
X-Forwarded-Encrypted: i=1; AJvYcCW7Z8kJTBl314LImus4oxCEPoh9IpGDAJ0VaAIYMPfL4/+dU223/iWsKjsNScqy1gX/Ui07ATqOSzrfTMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0LOWIp+7hXigpIjZYo5LaGDsujHZ51+ZGiUrMBEh6ouaX71l
	U8wKfSyir6RQLdQ4WgKrHYD6wpWxy98SjNLUei8S4PSnej8XLh6DcRvogfVwbFJ4iEUnbr9U5B1
	//h+lqHpJ2EN/ssTjwKFjzyUXMuU=
X-Google-Smtp-Source: AGHT+IHGBaYgl09WIkkXTY0FpbwRB5alMIvwnmaqvovo0tVEpK9+rxCOB5/EhbF4KQdJCBefMiKLjGc7HHSfhs3qIsY=
X-Received: by 2002:a05:6a00:1783:b0:71e:db72:3c87 with SMTP id
 d2e1a72fcca58-724bed27a8bmr300952b3a.20.1732046109377; Tue, 19 Nov 2024
 11:55:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com>
 <9dd3d046-6949-4e42-ab5a-af505f9b3981@web.de> <CAE8VWiJ62xT9shaEmUTOPF1OAztaWsr57m-wY9jyMJt5WFke5g@mail.gmail.com>
 <ea06c201-5a99-4875-b2d1-3bc4a35e2d5a@web.de> <CAE8VWiJqTB+PB1cFv2Sj8YbRWxgcrua3ZjyeWGF-7uqrsE95iw@mail.gmail.com>
 <133d5ad1-2eb8-40ac-925b-97ab39be0d5e@web.de>
In-Reply-To: <133d5ad1-2eb8-40ac-925b-97ab39be0d5e@web.de>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Wed, 20 Nov 2024 01:24:58 +0530
Message-ID: <CAE8VWiKrj0mcVvVCO5MOahj806LEwUSdmVw+rzLnGfbgqhTRRw@mail.gmail.com>
Subject: Re: x86/sev: Fix dereference NULL return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 12:26=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> > Using git blame I see that snp_kexec_finish() was first introduced in
> > 3074152e56c9b
> > and has stayed that way since. Should I just use that hash?
> Probably, yes.
> Would you insist to use only 12 characters from such an identifier?

I'm not sure what you mean but as suggested by the docs I'll use the first =
12
characters. Thank you for your help, I'll make these changes and send a v2.

Best Regards,
Shresth

