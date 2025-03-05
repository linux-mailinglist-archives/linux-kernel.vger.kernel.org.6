Return-Path: <linux-kernel+bounces-545852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D17A4F29D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A6F3AC071
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCB1CD3F;
	Wed,  5 Mar 2025 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RdQDNyoX"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33012B94
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134196; cv=none; b=D26YVqVLvR3Wx+eV8/GGf64sR+KTeNlMgg1VtVELX64JFujQIvLrrWVk/Fif0mTMgHUTFoksppmQ2dq4MYyLG66Z28iVLh8NlkvVxq/y8Laxnm8/+btnQsoV2DBW/odF1d4ecrZXP+2poUVcdqnnDf42iWf6OkIi50iXZ6rBw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134196; c=relaxed/simple;
	bh=EMm2jrTYaTVwDIb7fIqq/SrPdw8NSX14iaJPNP9LZ2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMYP4PjDLqAuObAshumqxBHRkqy0AMyQliZCnWrBBRoeKziX6LmwJtZa5Hblb5OfeejEXf0AZOqZydcvwXBhgBOBEfWCbHPthpuDRwj65TJ5yTNxc/Rs4IctixuGx/B9m/fe/WBP/xc8K1KOdJciZfGj3zzjMucRabj/8vpg2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RdQDNyoX; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e6119fc5e9bso556265276.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 16:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741134194; x=1741738994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4YiDLYB2Xyv0i3lSlJtAUBvLRrjWhRXqsvlbXIFqzQ=;
        b=RdQDNyoXM7IPhz6ZcFdiO2YoIKx40O8RUIXLuPFtlR7VRRQPCGAzgNL1OzG8Erl0aC
         sjqRZrpJMXwcMRCVLt4oWh3qM274V0LG56D0xUPgoHXHezq6iSEPpRc2FX+STQf/vvf0
         vaShhwR1oHgaGveBc0p9AlQqQeK4wpGqkzEqiazCdSc6XOtrt43aFVVZ+tiJqt4+oZEJ
         xKKLhP06KG8nsbGkRvBMHvyTg8eMiDSaCseRwpNWH/Sy81DkDR0vGNmiur6sW6Z2rxd/
         VDxgds4JokUodF1FYXoVsTxBBloLCrr7zG9aIXWJx46rZic/h+X+kOzqZC+61yWcME2L
         574Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741134194; x=1741738994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4YiDLYB2Xyv0i3lSlJtAUBvLRrjWhRXqsvlbXIFqzQ=;
        b=gaecpt+63NTjW1rGrGByo59aD+weM9OA4nnBnJYjyIOwUW0cgfzW6d9BCQHxgflEhr
         b1JpYIcNLsGTHdva82qJBwSyJ5mtP7+4BVrsRP0jxdN/ksHC40BmwBmkNXz9ITlxpxcC
         /HFI59biV0dcQgwhRyQyn6MBAmSkYkXFqTY1emWAYQunabZacNYFq2KhiVu+qyUWLoYA
         Egxg0xPGczpCwK0p+CrOmvY/jZKNMtHnYIb4sxkislogibC0OLhr9LEXj4QgGtFJtPNt
         VdxfmryXWbEAzfgXRVfdAtsqht5TYe5wEoOWM8RtqZVnleVl/Qrf3dQsMf94ew41D7ZW
         zBZA==
X-Forwarded-Encrypted: i=1; AJvYcCV9NHlYfBt8TZjevWVF7lFFVB3Yys5ynH+5rWHDfVvI78XatbiiYgYNi8exNqOTAvfEoN17q2rcdqH0nh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DoFWzJKUfNXOozlzhQ7Ve4I5ds9Z7OeS5So+FEcqhPp7ASVA
	kVF6J1ArAd9fUPvSIC/W3YG6rjzEY+NKqZfHPZVXYd/9Tz0tXnVKIWr3sqj+BsMPNf6Is+8DOkT
	MH/TM4w3kIoEOAmfLEOVo8gY1jzggoFD5N0W8
X-Gm-Gg: ASbGncvWnv3XMjGqbcPeQExDnc29bD6p2FyNMBoVN9kzWdv8TxW4mJ+/OvrAoTKZcE3
	ZkuHF7pP1p1aeXmMCUzzhNXFDkSftEqQjpXUKNRj05UujnJ/Xjib/aYWlZUc5IZfbeTNUmil2ff
	02qQmIBC61P4TZT2Fh1nZnTZA0YA==
X-Google-Smtp-Source: AGHT+IGOLBgkI0Cnk4j24VyTAA7d3ChoOytypLLEWobuiO8gJGe4SQT14bcYnIvbbRk+2AFMGCgF13qrN5gAjSrMY80=
X-Received: by 2002:a05:6902:1683:b0:e60:b17c:423f with SMTP id
 3f1490d57ef6-e611e1e7b91mr1711475276.28.1741134194264; Tue, 04 Mar 2025
 16:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com> <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com> <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com> <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
In-Reply-To: <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 19:23:03 -0500
X-Gm-Features: AQ5f1JrNkibyfl_g34dPES-fz_iVnpfHCEdaTH0VQZ1SvczNe3olHp_2oU87GRs
Message-ID: <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 9:47=E2=80=AFAM Eric Snowberg <eric.snowberg@oracle.=
com> wrote:
> > On Mar 3, 2025, at 3:40=E2=80=AFPM, Paul Moore <paul@paul-moore.com> wr=
ote:
> > On Fri, Feb 28, 2025 at 12:52=E2=80=AFPM Eric Snowberg <eric.snowberg@o=
racle.com> wrote:
> >>> On Feb 28, 2025, at 9:14=E2=80=AFAM, Paul Moore <paul@paul-moore.com>=
 wrote:
> >>> On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.c=
om> wrote:
> >>>> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> >>>>>
> >>>>> I'd still also like to see some discussion about moving towards the
> >>>>> addition of keyrings oriented towards usage instead of limiting
> >>>>> ourselves to keyrings that are oriented on the source of the keys.
> >>>>> Perhaps I'm missing some important detail which makes this
> >>>>> impractical, but it seems like an obvious improvement to me and wou=
ld
> >>>>> go a long way towards solving some of the problems that we typicall=
y
> >>>>> see with kernel keys.
> >>
> >> The intent is not to limit ourselves to the source of the key.  The ma=
in
> >> point of Clavis is to allow the end-user to determine what kernel keys
> >> they want to trust and for what purpose, irrespective of the originati=
ng
> >> source (.builtin_trusted, .secondary, .machine, or .platform). If we c=
ould
> >> go back in time, individual keyrings could be created that are oriente=
d
> >> toward usage.   The idea for introducing Clavis is to bridge what we
> >> have today with kernel keys and allow them to be usage based.
> >
> > While it is unlikely that the current well known keyrings could be
> > removed, I see no reason why new usage oriented keyrings could not be
> > introduced.  We've seen far more significant shifts in the kernel over
> > the years.
>
> Could you further clarify how a usage oriented keyring would work?  For
> example, if a kernel module keyring was added, how would the end-user
> add keys to it while maintaining a root of trust?

Consider it an exercise left to the reader :)

I imagine there are different ways one could do that, either using
traditional user/group/capability permissions and/or LSM permissions,
it would depend on the environment and the security goals of the
overall system.

--=20
paul-moore.com

