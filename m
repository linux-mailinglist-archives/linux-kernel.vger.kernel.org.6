Return-Path: <linux-kernel+bounces-178914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB648C5969
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A0A28300D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13C17EBB3;
	Tue, 14 May 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQGTrt9I"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5CE1292D2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702919; cv=none; b=TwuVl6ogKkLtVgh9M/zXZiII1lb5GzWAWKahtVCUH9QDoOUocW3EDJ4qmyRDzZ1E4PCXAqyXOBJFtE5m+0XJK22qN569SfMcvbmpGJfUmu68i7rN4pFIfwC+eJdebtH+PPG7zBNjg+H0p0Byr/L/03yfHM96lGPoPujrElyu87E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702919; c=relaxed/simple;
	bh=XSPCe4xxFqvcMIAr/wLrWhpaH8vmS5z/ad4RRHXg9RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aerKaQHWALjovOIiM5Ap6uYQqTtm4hc0UV2X1xwyyWVXtknDiJf1ZNsgk6HI0VSF2SAJ2aiQLUlDpcn+FhUdtzzS7hIxlpb2B3Pf+DaF1akkj43lDYixb9gZQ9CfKbytyqCDRCsFdydK8zNOHpIiDUN03iamyxHLTZKoFp+rsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQGTrt9I; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so6426115e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715702916; x=1716307716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKy0SWYRXhheNkTNgLPNmG3Z68/bNuWUrHpBXIM6cis=;
        b=jQGTrt9IImS8ehJESgUiRRJk/gNabOsVDIK7TMXezYdTi6S/1TKFD2wpj4k2mPTSvR
         RujMOzVr8HsyQkhGPiCmuKvTmSGTwXKBiSKk4K9kAs216ePmtjmuWjH82HF5RygCet65
         PckDPlW+EkEr2W5Ozk0BmalS0VJ/ys+UJO3lLrOZSPYvFh+ztfnP0n8WhSL+L57oKrCQ
         qfgKTOK+3f6R6iengUKfSH3tzLme8d2RPHr1HfVBdD5K3OQFWJ9PF9SqcTxWp6o2Fxq1
         sDWFUP6+xio3m1K6uB1bN48RqiAXJwhvQWO4rpWxzO0tRllV0Jdlrxb7zvkeeup/07Hw
         seYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702916; x=1716307716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKy0SWYRXhheNkTNgLPNmG3Z68/bNuWUrHpBXIM6cis=;
        b=qEE9cLCe8Wk2VbT/x4FgdSlPlQ/ecZCK4AFAQL4kMvTCqoYdALNRlmdSuhK4YK4nu9
         D6c6dC+hsu/6nMPBpati8MbjyhHhe61mvg0hjF49ncJ/I1Utkv271keEv95ZHPMHqk/h
         b9AZ+YoCfgpSL/HURQuWf8vo6rQehXfPWOr7Nef+SC3iAW3z/1cLcybm/O4MJe0RwBHY
         sXBkN7zWNqP0NCv8/W0W+fdLlIfrvKW/s2cFnJJEx/plGDjXavRLSPvnJdMjIj8Jubdj
         D6u8681et6vKfBAhXhQJakhW/t0AdQFCPhSo1DgInuTFyH4+lblP27wjUengaPHtCkQP
         uU+g==
X-Forwarded-Encrypted: i=1; AJvYcCWDjsve4xYVtUWbB2XmRG8KSZN2JDf+rtADwU8DC7VbnpbVbqT7yev+t3ACMWvf5fZGOcIu0HNTxPJOjy7JT5i7YJe0l2lskTu86kZU
X-Gm-Message-State: AOJu0YzjCpvIw4VR0t+9OFm3btWUxRbzcLxcl1JjXlRPt+p8en7i1Nm7
	vvndQLnG1XZWXe7usUPPs9FVfkzwGJzEo4kpSDeSHuPZo3QgxPS3/3PbRlB7Tri05uli5LOkA5K
	6sE31mRrBvHExa6U4j+qeYR+/lDo=
X-Google-Smtp-Source: AGHT+IGCA69EF9DerZfCfl7O8gngBZ6tRPZIy/9OT5bTEGZTv+njHDkK0v8AYchwCace99abPrm7ne4ItwLcI1RSlOQ=
X-Received: by 2002:a05:6512:304d:b0:522:35c6:d343 with SMTP id
 2adb3069b0e04-52235c6d3d6mr8549406e87.16.1715702915980; Tue, 14 May 2024
 09:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7efffaa0-6330-4b01-b3d2-63eb063cbbb0@gmail.com>
 <CAHx5RXD8qFmbEytrPcd40Pj0VRo7uOvZjucrMj6Xxqw73YyS1Q@mail.gmail.com>
 <212a9464-d52b-4730-95b9-5a0aebd38c91@gmail.com> <CAHx5RXCWW5M-eW5v65bAkQWZemsU2NTvDv3jA9_XKz=+YP56Qg@mail.gmail.com>
 <688e54ec-3b29-4e3b-a2c3-f2c83b9c97b7@lunn.ch> <CAHx5RXBFdzsgKXR94gdZd2b=uz8PJDg4OjLPJxKtsdhcjJq3Qw@mail.gmail.com>
 <e307a237-68e3-40c9-be31-4fe3d560ada2@lunn.ch> <CAHx5RXCF0=Soz_k88RGvJFGrajaxn=mVnqpb99GAQ=b7XOcWiw@mail.gmail.com>
 <732d8bb2-1d4f-4958-b130-0bd15a407271@gmail.com> <CAHx5RXDaweFTF_Qt0GdBH4nBeMqwL4VVto7xzHBvFgFL5n=Ebg@mail.gmail.com>
 <c8c01e53-0a45-4319-88ff-bfb0caba150c@lunn.ch>
In-Reply-To: <c8c01e53-0a45-4319-88ff-bfb0caba150c@lunn.ch>
From: Stephen Langstaff <stephenlangstaff1@gmail.com>
Date: Tue, 14 May 2024 17:08:24 +0100
Message-ID: <CAHx5RXDzN93WaYFe2bk6m2TmMC+A9vsmhodRFmZi17cFY5CrWQ@mail.gmail.com>
Subject: Re: drivers/net/dsa/dsa_loop_bdinfo.c build problems
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, OlteanV@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 1:32=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> So try to making FIXED_PHY =3D m, and load it after dsa_loop_bdinfo.ko.

In my configuration FIXED_PHY is selected by several other modules:
  =E2=94=82 Selected by [y]:
  =E2=94=82   - FSL_DPAA_ETH [=3Dy] && NETDEVICES [=3Dy] && ETHERNET [=3Dy]=
 &&
NET_VENDOR_FREESCALE [=3Dy] && FSL_DPAA [=3Dy] && FSL_FMAN [=3Dy]
  =E2=94=82   - FWNODE_MDIO [=3Dy] && NETDEVICES [=3Dy] && MDIO_DEVICE [=3D=
y] &&
(ACPI [=3Dy] || OF [=3Dy] || COMPILE_TEST [=3Dn])
  =E2=94=82   - OF_MDIO [=3Dy] && NETDEVICES [=3Dy] && MDIO_DEVICE [=3Dy] &=
& OF [=3Dy]
&& PHYLIB [=3Dy]

..so it looks pretty tied up with the MDIO support which I guess I
will need for the real PHY!

If I sorted out building the dsa_loop_bdinfo.c code as a built-in do
you think that would solve the ordering issue?

