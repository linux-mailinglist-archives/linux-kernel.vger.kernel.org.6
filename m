Return-Path: <linux-kernel+bounces-535704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6DA4763F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FE43B1526
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14721E0BE;
	Thu, 27 Feb 2025 07:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYO+tYcI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB14821E087
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639853; cv=none; b=MyZpeGd+5sItxRV/2XaoH0Bo6WM7qrNITZ7QXRTR6/xbyfSfruW4UPgrUjO7wYLALD7amI2T9ZWPUVgMWj4ZqqK7U7kdjguHZJLV6p9p4CmWYF8gPASbEpuRg83E7KlbqEsBUJVKgUlr4Tbe4bSv3rI+NbCfht5GuN9sjNb3Jqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639853; c=relaxed/simple;
	bh=wGhmY4K+cfsz+Ts0JI7fTq+0yQhI6j1x0t4HpKbP2FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvG2N6wdJdXanQhJUndzhlT8AsehxhdqOc3I7Y+gGS2CZciYOAyL91B6TAdFk9abpeEdpVf873NpyPONr8h98XBAp4KTs6adbgZHOnEAZ1GPTwpxVofQ3b1syu6Glne01RujWCZdAW2ZjF7Uz33QEDylZX37tCuvknc41MJZH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYO+tYcI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30b83290d39so5369231fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740639850; x=1741244650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5pSnAlORQX9yo5NqS9jLGuSkbz6XSEuBHk2B9Ea63/k=;
        b=MYO+tYcI/N1Mj/Hif7F1y2VrYX0BDt4zY3cSouYbqojRGJhIc0BLbFtSJcAToA2v5u
         8/6aVa3AtnBVLNHG4VpKaHB4Dx708opPPPcZjY3h3YhO5pyjR8b6HX6PfpX/xvWbTbR9
         pZL5Bb16PesKAdUCImrpcArh7zbCrFgAuPueAPeOip8qEZoldI0x0H5paT3Qi1aL1rR5
         u3cjCmtKPWGOI5hNHmBS0+HuPVFWfiN8YpC5hdO0jA7eq0S4t4WTURs79zgaUf8GHqq+
         AeDcoeB4QoCptFATuB1wWGUNhXMOlO7anD7bLT8I1F6XEWJEfuzJXL96WsLRnB1nITla
         fE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639850; x=1741244650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pSnAlORQX9yo5NqS9jLGuSkbz6XSEuBHk2B9Ea63/k=;
        b=dAYtKHSalvg2361RRSpcZP1ZRg/KkxPy6n5dTxvGNd3Gd8YLTAd1L1LCHX59WnOqBD
         tt9yLUcJjl2qWAR3ro3cILvmP7U4xZ3ynJKu5tpZUNiJzgeIM1DCaDLbTYIcBjEl7sUa
         8JaZ13FG6NY1v5jz1ybA4DlhKP5okM0QIsqgELFBBr4n748l6rUBT25DSeM24dqi8g/F
         7eCduVdq5G0z0kceUY408M7CWUC5IWSyN0bJWyFzZxFWe3JR6hNwyam1uOIY7La0vtt3
         XJ5fkim0PDE+t2ZUBE97VsSodCA5MXKQ0MvUxA9BPpG1ob4Qhqs4sbe8MHPFWW14oBaL
         /3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVuemyHYU3Jv0yWm0vPcnNwhfZSQegtNrjQLtQh19oyvIAMf6ScPJRo4ZA7WDM1Vz/0rF2Xf2L1GJ4Qx3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPagrcZlmCo2/HtPkcJz3oHnfsWDrXRjq/MBiveYoxP+j/0Iy
	FlSGarup4wXaPipJ4zgROslPH8dnuTlhjnAUavQ+t9ygyL2na+FE89TZC1thIOed6UUVRBkbRDi
	dR1S06baSDyFpytKwk0STayLmYaQ=
X-Gm-Gg: ASbGncu9bMmxt51TERZ1jlG2Vbd6BB7WmnnWxEROhQr2hpp+EKr0CH47WJqMbifCOje
	g/Ntf894CpAZuMvjqBux2WjIWWAZCvbdrJ/0p6xldw1bh0Ibnjoth8MtOc+3an9ik+h6zhvibya
	VFvfMWhvE=
X-Google-Smtp-Source: AGHT+IEJB9xY5jdV4yA0qX96NmnQQAhEOgjMykCaPQFjWaqdpoNDmqQyMdSO8o9a1TpCdng2oPuHncXDTZDKMC+urTU=
X-Received: by 2002:a05:651c:220a:b0:2ff:d0c4:5ffe with SMTP id
 38308e7fff4ca-30a5989ec23mr108942871fa.16.1740639849425; Wed, 26 Feb 2025
 23:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226133703.3c9775c9e50e198abc9b9f6e@linux-foundation.org>
 <20250226225605.2000-1-sj@kernel.org> <CAJGd785Eu7iuVwYnewaUm38NJcKzB-xkZwdRiYR9Yo9Qwaoffg@mail.gmail.com>
In-Reply-To: <CAJGd785Eu7iuVwYnewaUm38NJcKzB-xkZwdRiYR9Yo9Qwaoffg@mail.gmail.com>
From: bus710 <bus710@gmail.com>
Date: Wed, 26 Feb 2025 23:03:57 -0800
X-Gm-Features: AQ5f1JpVLtjZYY8z8VdY3q00BIa0I40J0PTII1FHJ04t63xdJqRQe8KrnJyuBBs
Message-ID: <CAJGd784+kQ8NXSp1=9tZW+4wYvTh6SkW7ySaB0TVGcinjjcEdQ@mail.gmail.com>
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="000000000000e855b8062f1a4bde"

--000000000000e855b8062f1a4bde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:07=E2=80=AFPM bus710 <bus710@gmail.com> wrote:
>
> On Wed, Feb 26, 2025 at 2:56=E2=80=AFPM SeongJae Park <sj@kernel.org> wro=
te:
> >
> > On Wed, 26 Feb 2025 13:37:03 -0800 Andrew Morton <akpm@linux-foundation=
.org> wrote:
> >
> > > On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wrot=
e:
> > >
> > > > From: bus710 <bus710@gmail.com>
> > >
> > > Full names are preferred, please.  Actually I think it's "required".
> >
> > Thank you for letting me clearly know this.  I'll request full names to=
 DAMON
> > patch authors from next time.
> >
> > bus710, we could still update the patch before it is merged into the ma=
inline.
> > If you could, please let us know your full name and if we can update th=
e patch
> > with that.
> >
> > >
> > > I'll apply it anyway due to the patch's minor nature, thanks.
> >
> > I agree this is a simple enough patch that the name doesn't really matt=
er.
> > Thank you Andrew :)
> >
> >
> > Thanks,
> > SJ
>
> Oh, yes. I was a little worried if I added too much noise for such a
> small work, but I shouldn't miss this opportunity to leave my name in
> Linux history.
> Let me prepare a new patch as soon as possible.

Hi all,

Please find the attached patch.
Based on the latest one, from @Andrew Morton I just replaced my ID
with my real name as well as updated the subject.

Thank you,
Seongjun Kim

--000000000000e855b8062f1a4bde
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-samples-damon-a-typo-in-the-kconfig-sameple.patch"
Content-Disposition: attachment; 
	filename="0002-samples-damon-a-typo-in-the-kconfig-sameple.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m7n00g7d0>
X-Attachment-Id: f_m7n00g7d0

RnJvbTogU2VvbmdqdW4gS2ltIDxidXM3MTBAZ21haWwuY29tPgpTdWJqZWN0OiBbUEFUQ0ggdjJd
IHNhbXBsZXMvZGFtb246IGEgdHlwbyBpbiB0aGUga2NvbmZpZyAtIHNhbWVwbGUKRGF0ZTogV2Vk
LCAyNiBGZWIgMjAyNSAxMDo0MjowNCAtMDgwMAoKVGhlcmUgaXMgYSB0eXBvIGluIHRoZSBLY29u
ZmlnIGZpbGUgb2YgdGhlIGRhbW9uIHNhbXBsZSBtb2R1bGUuICBDb3JyZWN0Cml0OiBzL3NhbWVw
bGUvc2FtcGxlLwoKTGluazogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDI1MDIyNjE4NDIw
NC4yOTM3MC0xLXNqQGtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogU2VvbmdqdW4gS2ltIDxidXM3
MTBAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBTZW9uZ0phZSBQYXJrIDxzakBrZXJuZWwub3Jn
PgpSZXZpZXdlZC1ieTogU2VvbmdKYWUgUGFyayA8c2pAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1i
eTogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCgogc2FtcGxl
cy9kYW1vbi9LY29uZmlnIHwgICAgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKLS0tIGEvc2FtcGxlcy9kYW1vbi9LY29uZmlnfnNhbXBsZXMt
ZGFtb24tYS10eXBvLWluLXRoZS1rY29uZmlnLXNhbWVwbGUKKysrIGEvc2FtcGxlcy9kYW1vbi9L
Y29uZmlnCkBAIC0zLDcgKzMsNyBAQAogbWVudSAiREFNT04gU2FtcGxlcyIKCiBjb25maWcgU0FN
UExFX0RBTU9OX1dTU0UKLSAgICAgICBib29sICJEQU1PTiBzYW1lcGxlIG1vZHVsZSBmb3Igd29y
a2luZyBzZXQgc2l6ZSBlc3RpbWF0aW9uIgorICAgICAgIGJvb2wgIkRBTU9OIHNhbXBsZSBtb2R1
bGUgZm9yIHdvcmtpbmcgc2V0IHNpemUgZXN0aW1hdGlvbiIKICAgICAgICBkZXBlbmRzIG9uIERB
TU9OICYmIERBTU9OX1ZBRERSCiAgICAgICAgaGVscAogICAgICAgICAgVGhpcyBidWlsZHMgREFN
T04gc2FtcGxlIG1vZHVsZSBmb3Igd29ya2luZyBzZXQgc2l6ZSBlc3RpbWF0aW9uLgpAQCAtMTUs
NyArMTUsNyBAQCBjb25maWcgU0FNUExFX0RBTU9OX1dTU0UKICAgICAgICAgIElmIHVuc3VyZSwg
c2F5IE4uCgogY29uZmlnIFNBTVBMRV9EQU1PTl9QUkNMCi0gICAgICAgYm9vbCAiREFNT04gc2Ft
ZXBsZSBtb2R1bGUgZm9yIGFjY2Vzcy1hd2FyZSBwcm9hY3RpdmUgcmVjbGFtYXRpb24iCisgICAg
ICAgYm9vbCAiREFNT04gc2FtcGxlIG1vZHVsZSBmb3IgYWNjZXNzLWF3YXJlIHByb2FjdGl2ZSBy
ZWNsYW1hdGlvbiIKICAgICAgICBkZXBlbmRzIG9uIERBTU9OICYmIERBTU9OX1ZBRERSCiAgICAg
ICAgaGVscAogICAgICAgICAgVGhpcyBidWlsZHMgREFNT04gc2FtcGxlIG1vZHVsZSBmb3IgYWNj
ZXNzLWF3YXJlIHByb2FjdGl2ZQpfCg==
--000000000000e855b8062f1a4bde--

