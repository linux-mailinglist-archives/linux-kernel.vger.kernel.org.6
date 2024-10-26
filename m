Return-Path: <linux-kernel+bounces-383303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C59B19C7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD87C282656
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1142813D24C;
	Sat, 26 Oct 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBW7SAzG"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859FF5473C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729960028; cv=none; b=OPbTtcISCDGxAGJaY9l7jJKvHC6ExMREKUTmmwJVBrhMfbEfsz88LJ0I3dhpF6awjOf46SzaPhEPKdh3kqbp0tFKUOcvUbvGkF3t/tbU4koz38dWfLK2H5LTPhDvvBTV36JcwXeI51EUAoYuEjHZDlcMMXagcc8xKdAaFcKus/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729960028; c=relaxed/simple;
	bh=A2d4RnFX3pil5tSgYj3ITKZrgzZRv1eCgaJoYuXQWxA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:Subject:To:
	 In-Reply-To; b=p6lh1GsPJZSk6bMTC6XXWA/ZeyIC1EMcIOf6wTXJ7KQW9Y/sgHF+wnYIdPdAiGBfccytcuKJeGU0YClUZRM8CFqvvOaX9k/pFAVY8nyD/ca+iIdU7CVEx3Fqiwcf3Oc7oc7J1g4u6fScq+BCuobiS5XPqOYWNquV0R5yGIVp+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBW7SAzG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e59a9496f9so34194307b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729960025; x=1730564825; darn=vger.kernel.org;
        h=in-reply-to:to:subject:cc:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTtKtWKs11bD7iRvVxgQuCeRIcQVhURI1g77rkuqqLQ=;
        b=aBW7SAzGRfvAfoii0QgVoC1OVLvdQoJkT37KiK5HjbK62l0sG27+n3Va8pFAOhfnPk
         U5zVv+NQBuMA/SZD9Tv+BIekzMoWonIzmNoyIizbTs8+yiGkTc1ccLzYw/BkTi7KM665
         fPb403fC6ZFbbeStuo+Ccn/ONQM+moWfLhjPaOIAJUJFem3ktS94d3dSetcotfT1WXx+
         HCsjxTL1dB81GPZSfzQEEEp554MzsNKQL5o3eBvbqU8gXkE1sNW8CaPnB4fEkeriPYcv
         JGjazC6MdUHobD45OMCJlZRKKVnEyJRiyhGxVN/Rc0TD69bLMNYSFVzqcCoAFNlLxiV8
         Jigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729960025; x=1730564825;
        h=in-reply-to:to:subject:cc:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTtKtWKs11bD7iRvVxgQuCeRIcQVhURI1g77rkuqqLQ=;
        b=G0VS4Z6OxWImTYBzowT4CNA4/8GLfyJ9aeKbT83O9QrkuwJI43xT1KPNqlGsbOMkFV
         fgIVhZErVSE6ZudCxBCWeHxg7kSy40WyOVPTwhvn43b9L+qj+ddoAAoi31XRWSjjScWT
         TcxE14sN/tyIygob/fG8DNdyp4hgOiuxCZUSpCpQns/F7xjIvP0AcSMXyMTsCjk53eER
         5WqQl50Ku8Dxlr/3MFA9DfD6NTHzO3vgET4zjcODNlPaiv4zu7HL5CKs0i516cCk/iB8
         fS4AXZbl0LI5tbKnJ83SQYzSaY9lvz4JhkTSKTEnv5+S/e4MvyDJRrwMuETPY1SLQQCl
         +vlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmfukwC9WHZBm1I3HhOaB8GEl5d2o6suDQYHG77oYHQvlf+cfXYru0RD89joBtsBQ4m5LEwuLxBoU4lyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkMZvbI+NjJJ5e4dXYBHRO2KDGzIza2eGXgYcVBgpbezbzTlj
	r3LUcgUQAS1niTHnBSXv9PClQnR17+rHkbmuQEgS/FCabhDl+GtD
X-Google-Smtp-Source: AGHT+IE0YLoWHP2mh/IBpJGKorWV3NwLz/xAUhPhboCkZTbimCpM5+rlYVLpVXcObR5/104mAOOHUw==
X-Received: by 2002:a05:690c:6f8b:b0:6e0:447:f257 with SMTP id 00721157ae682-6e9d89b85f5mr33296407b3.22.1729960025509;
        Sat, 26 Oct 2024 09:27:05 -0700 (PDT)
Received: from localhost ([174.128.181.101])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c96991sm7082527b3.123.2024.10.26.09.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 09:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Oct 2024 19:27:02 +0300
Message-Id: <D55VNB4366Q6.16EY7DUK2891U@gmail.com>
From: "John Mcenroy" <johnmcenroystudios@gmail.com>
Cc: <geert@linux-m68k.org>, <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
To: <james.bottomley@hansenpartnership.com>
X-Mailer: aerc 0.18.2.r87.gd0484b15
In-Reply-To: <7ee74c1b5b589619a13c6318c9fbd0d6ac7c334a.camel@HansenPartnership.com>

Hello Linux Community


Alfred Tennyson
Freedom

Of old sat Freedom on the heights,
    The thunders breaking at her feet;
Above her shook the starry lights;
    She heard the torrent meet.

There in her place she did rejoice,
    Self-gather=E2=80=99d in her prophet-mind,
But fragments of her mighty voice
    Came rolling on the wind.

Then stepped she down thro=E2=80=99 town and field
    To mingle with the human race,
And part by part to men reveal=E2=80=99d
    The fullness of her face =E2=80=93

Grave mother of majestic works,
    From her isle-altar gazing down,
Who, Godlike, grasps the triple forks,
    And, king-like, wears the crown,

Her open eyes desire the truth.
    The wisdom of a thousand years
Is in them. May perpetual youth
    Keep dry their light from tears;

That her fair form may stand and shine,
    Make bright our days and light our dreams,
Turning to scorn with lips divine
    To falsehood of extremes.


=D0=90=D0=BB=D1=8C=D1=84=D1=80=D0=B5=D0=B4 =D0=A2=D0=B5=D0=BD=D0=BD=D0=B8=
=D1=81=D0=BE=D0=BD
=D0=A1=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=B0

=D0=A1=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=B0 =D0=B4=D1=80=D0=B5=D0=B2=D0=BB=
=D0=B5 =D0=BE=D0=B1=D0=B8=D1=82=D0=B0=D0=BB=D0=B0
=D0=9D=D0=B0 =D0=B2=D1=8B=D1=81=D1=8F=D1=85 =D0=B3=D0=BE=D1=80; =D0=B2 =D1=
=81=D0=B8=D1=8F=D0=BD=D1=8C=D0=B8 =D0=B7=D0=B2=D0=B5=D0=B7=D0=B4
=D0=9D=D0=B0=D0=B4 =D0=BD=D0=B5=D1=8E =D0=BD=D0=B5=D0=B1=D0=BE =D1=82=D1=80=
=D0=B5=D0=BF=D0=B5=D1=82=D0=B0=D0=BB=D0=BE,
=D0=9F=D0=BE=D0=B4 =D0=BD=D0=B5=D0=B9 =D0=B4=D1=80=D0=BE=D0=B1=D0=B8=D0=BB=
=D1=81=D1=8F =D0=B3=D1=80=D0=BE=D0=BC =D0=BE=D0=BA=D1=80=D0=B5=D1=81=D1=82.

=D0=9E=D0=B3=D0=BD=D0=B5=D0=BC =D0=BF=D1=80=D0=BE=D1=80=D0=BE=D1=87=D0=B5=
=D1=81=D0=BA=D0=BE=D0=B3=D0=BE =D0=B4=D1=83=D1=85=D0=B0
=D0=A2=D0=B0=D0=BC =D0=B4=D0=B8=D0=B2=D0=BD=D1=8B=D0=B9 =D0=BB=D0=B8=D0=BA =
=D0=B5=D1=91 =D0=B1=D0=BB=D0=B8=D1=81=D1=82=D0=B0=D0=BB;
=D0=9D=D0=BE =D0=BC=D0=BE=D1=89=D0=BD=D1=8B=D0=B9 =D0=B3=D0=BB=D0=B0=D1=81 =
=D0=B5=D1=91 =D0=B4=D0=BE =D1=81=D0=BB=D1=83=D1=85=D0=B0
=D0=9F=D0=BE=D1=80=D0=BE=D1=8E =D0=BA =D0=BB=D1=8E=D0=B4=D1=8F=D0=BC =D0=B4=
=D0=BE=D0=BB=D0=B5=D1=82=D0=B0=D0=BB.

=D0=97=D0=B0=D1=82=D0=B5=D0=BC =D0=BD=D0=B8=D0=B7=D1=88=D0=B5=D0=B4 =D0=BA =
=D0=BF=D0=BE=D0=BB=D1=8F=D0=BC =D0=B8 =D0=B3=D1=80=D0=B0=D0=B4=D0=B0=D0=BC,
=D0=A1=D0=BC=D0=B5=D1=88=D0=B0=D0=BB=D0=B0=D1=81=D1=8C =D1=81 =D1=81=D0=BC=
=D0=B5=D1=80=D1=82=D0=BD=D0=BE=D1=8E =D1=82=D0=BE=D0=BB=D0=BF=D0=BE=D0=B9
=D0=98 =D0=BF=D0=BE=D0=BD=D0=B5=D0=BC=D0=BD=D0=BE=D0=B3=D1=83 =D0=BD=D0=B0=
=D1=88=D0=B8=D0=BC =D0=B2=D0=B7=D0=B3=D0=BB=D1=8F=D0=B4=D0=B0=D0=BC
=D0=A0=D0=B0=D0=B7=D0=BE=D0=B1=D0=BB=D0=B0=D1=87=D0=B8=D0=BB=D0=B0 =D0=BE=
=D0=B1=D1=80=D0=B0=D0=B7 =D1=81=D0=B2=D0=BE=D0=B9.

=D0=A2=D0=B0=D0=BA, =D0=B2 =D0=BC=D0=B8=D1=80 =D1=8F=D0=B2=D0=B8=D0=B2=D1=
=88=D0=B8=D1=81=D1=8C =D0=BC=D0=B8=D1=80=D0=BE=D0=BB=D1=8E=D0=B1=D1=86=D0=
=B5=D0=BC,
=D0=9C=D0=B5=D0=B6 =D0=BD=D0=B0=D1=81 =D0=B2=D0=BE=D0=B7=D0=B4=D0=B2=D0=B8=
=D0=B3=D0=BB=D0=B0 =D1=81=D0=B2=D0=BE=D0=B9 =D0=B0=D0=BB=D1=82=D0=B0=D1=80=
=D1=8C,
=D0=92=D0=BE=D0=BE=D1=80=D1=83=D0=B6=D0=B0=D1=81=D1=8C, =D0=BA=D0=B0=D0=BA =
=D0=B1=D0=BE=D0=B3 =D1=82=D1=80=D0=B5=D0=B7=D1=83=D0=B1=D1=86=D0=B5=D0=BC,
=D0=91=D0=BB=D0=B5=D1=81=D1=82=D1=8F =D0=BA=D0=BE=D1=80=D0=BE=D0=BD=D0=BE=
=D1=8E, =D0=BA=D0=B0=D0=BA =D1=86=D0=B0=D1=80=D1=8C.

=D0=95=D1=91 =D0=BE=D1=82=D0=B2=D0=B5=D1=80=D0=B7=D1=82=D1=8B=D0=B9 =D0=B2=
=D0=B7=D0=BE=D1=80 =D1=81=D1=82=D1=80=D0=B5=D0=BC=D0=B8=D1=82=D1=81=D1=8F
=D0=9B=D0=B8=D1=88=D1=8C =D0=BA =D0=BF=D1=80=D0=B0=D0=B2=D0=B4=D0=B5, =D0=
=BA =D0=BC=D1=83=D0=B4=D1=80=D0=BE=D1=81=D1=82=D0=B8 =D0=BE=D1=82=D1=86=D0=
=BE=D0=B2.
=D0=9E, =D0=BF=D1=83=D1=81=D1=82=D1=8C =D0=B6=D0=B5 =D0=B2=D0=B5=D1=87=D0=
=BD=D0=BE =D0=BE=D0=BD =D0=BD=D0=B5 =D1=82=D0=BC=D0=B8=D1=82=D1=81=D1=8F
=D0=A1=D0=BB=D0=B5=D0=B7=D0=BE=D0=B9 =D0=BD=D0=B0=D0=B4 =D1=82=D1=83=D0=BF=
=D0=BE=D1=81=D1=82=D1=8C=D1=8E =D1=81=D0=BB=D0=B5=D0=BF=D1=86=D0=BE=D0=B2!

=D0=9E, =D0=BF=D1=83=D1=81=D1=82=D1=8C, =D0=B2=D0=BE=D1=81=D1=81=D0=B5=D0=
=B2 =D0=BD=D0=B0 =D1=82=D1=80=D0=BE=D0=BD =D0=BD=D0=B5 =D0=B7=D1=8B=D0=B1=
=D0=BA=D0=B8=D0=B9,
=D0=9D=D0=B0=D0=BC =D1=81=D0=B2=D0=B5=D1=82=D0=B8=D1=82 =D0=BF=D1=80=D0=B0=
=D0=B2=D0=B4=D0=BE=D0=B9 =D1=81=D0=BA=D0=B2=D0=BE=D0=B7=D1=8C =D1=82=D1=83=
=D0=BC=D0=B0=D0=BD
=D0=98 =D1=83=D1=81=D1=82 =D0=B1=D0=BE=D0=B6=D0=B5=D1=81=D1=82=D0=B2=D0=B5=
=D0=BD=D0=BD=D0=BE=D0=B9 =D1=83=D0=BB=D1=8B=D0=B1=D0=BA=D0=BE=D0=B9
=D0=A0=D0=B0=D1=81=D1=81=D0=B5=D0=B5=D1=82 =D0=BA=D1=80=D0=B0=D0=B9=D0=BD=
=D0=BE=D1=81=D1=82=D0=B5=D0=B9 =D0=BE=D0=B1=D0=BC=D0=B0=D0=BD!


Linux user
John Mcenroy
---
johnmcenroystudios@gmail.com






