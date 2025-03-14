Return-Path: <linux-kernel+bounces-561410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A785A61144
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4FA1769EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBCE1FECDE;
	Fri, 14 Mar 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcRiIABm"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482C201246;
	Fri, 14 Mar 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955319; cv=none; b=sM8pbQzDTGJTZrBJdfzJ/oEsS4ZVd0Zx4ir8apd2fb1y7+Vh4jUs342vzbtJCfjcwRp+Umg2JdpD/+JMbsvysA3qGGQcF/1HYZhwHnew/MoZa1p31l6CTJvLMs1PSLKzvHIEaM0C3cH73nm91NcHzxaMMsjnvPk5dC9k0Mtru8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955319; c=relaxed/simple;
	bh=klMC5/G+XXKWK1/4aNII/hB//YRrPjWupxCwKflvsZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAdQDr9gujlYP7sGCrWlhU6B9XZsZhJXT0NB0dFzdCVu1amkEwyIhOoBTLD4azNREqCAlUDxlUMlwOzdS0x+WjLK1L1NOS9sjvW50jFT7noI+6Qn/tvYF90UCx8bnYh/KIf53iqRpgLLa25C3qWwbeDPc5TMMjTXPp/notSDKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcRiIABm; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fd0adce179so882853eaf.2;
        Fri, 14 Mar 2025 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955317; x=1742560117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlJlsNrADwfk/WswqbOtJdzenxkh/DAhh8ltAuIyzso=;
        b=DcRiIABmBv4eYxfwyfCAl45RtMJFevOM41UVtHcN0ms5S4hiw5AwXgXPvLo/pqLBQP
         9oSHjImjIEJIUBZyewYKSBESXgMWOOoOF06QVu4qXtr2cIvNFxtxZ+IR3Y++WhOqV9BL
         jh7OBLcyYt/Y/unWj4xIZ3guEPaeBus7w7pqLi7XnkHziBNfGX81H6QkRiDi/+z7DBtg
         Hen2sfiZAi6Gvi2Z2DzC5bAGSCPmhp/Qxh6F94Rd/pfqtIa6rvB/pKBAqaYOhluLqZG6
         mHcK6bZgyrr3vk1w/dl/bIHxiKtM4bSoj54kvjvUkzjh08CSLEnSkNXJquVu/5wv5mlx
         kP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955317; x=1742560117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlJlsNrADwfk/WswqbOtJdzenxkh/DAhh8ltAuIyzso=;
        b=I1E5njbghUlelimOgzNZ8a7DizzGJ3C3vX+Z5wt6OsVJkK+a5RrUIE3buxEo2CSCv8
         n8haH63Wb83A45cRaJqhni3ojPUbH25PoAukyIPf5loR4sjigRKJOq/Kk6fGD5M85tL1
         vWTVRPB8RWrTkSV+Wv9mm13CiGN84HM39+PlZJ4jbAfZlOGA+tZx220BkeqAKPtiwrn7
         tiKsfgvw6ME+2LYLg7iRd98ikIvVu51i6YqHZ0Ko7AdgHrd0if3RqYKMbzSusKDy21my
         DeDFFh/EM1VpulUDhbiWnpmX+7FQhnL0yLCaVy6N67Gh8dvrrIiybHzgBTBAdnt0rgwV
         gPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTRfutDTgrUxpm7U5QT2OV8JawfPch1mz8MpN21BxYSgLdb5BczZOyT5NjdPDKJRiud+sAL57QdqxqCC4=@vger.kernel.org, AJvYcCXiY+bDoeRK21T8e4Cc9K33FnE8hkeodhXjUA0mhN5K0p4FjTt9nPc1B/0GVBPRDafe1yb3BJIzqRdpOKDIw82DEzV8SA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qTgtYEfZEOnNYYu4gQDH8WZJoe8/BaFM/XKMfq7QRi+6QQHd
	ybf0pAb3MsMCRL3q08gUiNo9d6a7yNaacj/7sK1Bl2d3Pjg572ewnm/DE4XhX+o9EFcKNpvxdbj
	PFgnwkGSTgUWVlGNL/nOUwNyraek=
X-Gm-Gg: ASbGncujaFL1ajCplzCp0fUjJau4wqcYVhF/hrnE24Jatrrk1CFZMbaMG06L7kxkARF
	nfpQZsCaEps4H6ISdMDHVIQTckrFwX2JcJrMwhO4Ze4cS0VsJ6v0AjXrcCxy1bpLgz8HtVtfQSl
	6unejB6F+fPt0DDVYwYZpSCf0lWDvT50rdbFzeIuPu3mrGZSgss7qhPla/bnPP
X-Google-Smtp-Source: AGHT+IHii+40cEpqtFlvTurXoBG+9FfqAiGsJIzzx2PLkMDkg6GfMo6DOeNGhNO06/Gu6CgK57oRdIbLgFz+7Ep5nzg=
X-Received: by 2002:a05:6820:1e0b:b0:601:ce76:c46a with SMTP id
 006d021491bc7-601e44426a4mr1063308eaf.0.1741955315435; Fri, 14 Mar 2025
 05:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313151744.34010-1-gasper.nemgar@gmail.com>
 <4f1d9817-60b1-433d-b7a8-f37057e0980a@canonical.com> <f581c3d25a270801de35b7d0380cbd13c4c4a131.camel@irl.hu>
In-Reply-To: <f581c3d25a270801de35b7d0380cbd13c4c4a131.camel@irl.hu>
From: =?UTF-8?Q?Ga=C5=A1per_Nemgar?= <gasper.nemgar@gmail.com>
Date: Fri, 14 Mar 2025 13:28:09 +0100
X-Gm-Features: AQ5f1Jq3_ssz15EqUKb5dhebvDtIJUaFBwLS6ptmObQw_gA2Eg16SPz_MgyicFY
Message-ID: <CAKi4K-j-j_SdKOAvxSWeQ9qPN-tMVicQ_nbKkNDvm8rEsY_N3g@mail.gmail.com>
Subject: Re: [PATCH] Fixed ideapad-laptop driver to support Yoga 9 2 in 1
 14imh9 unknown keys
To: Gergo Koteles <soyer@irl.hu>
Cc: Ike Panhc <ike.pan@canonical.com>, linux-kernel@vger.kernel.org, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
This specific laptop has one star with s in the middle which is
already handled by the driver and is assigned to key favourites.
There is another button with only a star, I think it is ok to assign
it to KEY_PROG1.

Thanks, Ga=C5=A1per


On Fri, 14 Mar 2025 at 12:52, Gergo Koteles <soyer@irl.hu> wrote:
>
> Hi Ga=C5=A1per,
>
> On 3/13/25 23:17, Ga=C5=A1per Nemgar wrote:
> >       /* Specific to some newer models */
> >       { KE_KEY,       0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
> >       { KE_KEY,       0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> > +     /*Star- (User Asignable Key)*/
>
> Asignable -> Assignable?
> Could you please add a space before/after the body of the comment?
>
> > +     { KE_KEY,       0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },
>
> Other Ideapads map this star key to KEY_FAVORITES, for consistency I
> think it would be better if this one mapped there too.
>
> Thanks,
> Gergo
>
>

