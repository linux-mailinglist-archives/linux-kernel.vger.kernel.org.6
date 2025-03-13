Return-Path: <linux-kernel+bounces-559233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA78A5F123
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C804E189F309
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB52641DD;
	Thu, 13 Mar 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC4UC/pj"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DE1D88D0;
	Thu, 13 Mar 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862593; cv=none; b=VNZEYycf1zmAVLlOVhmBBPA7A0serRo22lvTbyXFVC+B8xLcYsgVY0sU8MhP4I+V3NIHhjOWqMnDRu+YkcvYDhKhTZxMMaFTkzEjP78bdTKxQpYwHxzCvLrdbSIvUIZUDe5ta/69Khz9PD+hU+RH9n33+UVa+0Kqwyx67MfxEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862593; c=relaxed/simple;
	bh=WvEgZ2VU8iAw9Pl1DlzhPxdA+1nrFUMdbUQAq1IlBnk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iqHISExLgQVlYlmd044ftTeZg91miKzgMG9RNkXy63mmAeX0gVmi74hFPlhXCNtzj1crYdu8JrkH9uzQSK077WZMtEXX8HjGYLzMI37AlouBt+Nozd5xtU2AiLXvNn/O4DiyfC8f1vlPE2rXsmjXit7lLUM2nba46x1gsjGN36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC4UC/pj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e64700a38cso1175466a12.1;
        Thu, 13 Mar 2025 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741862588; x=1742467388; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/wMjl7Q/J6WQRlQUTRmWAqcrf0d7pU34h1ehg31lfI=;
        b=TC4UC/pj71DlOZESrtddTEX4cwNdM4leH+wUpa0HLNgmFznQgff77BiGgAAQnxcQj7
         dWOtQPo6BgG4YFwW/YbYq/3grgSf5ZVhMdL2Je2TGgLal7XiydoLxOKxUSqD5Ev/TqbY
         SApOpJBo0qNInuKwc5vVn0+XkHQ0lcH7dXfOoC3n5VlxR96GR01Bcv1ijZIxZLyUVBGv
         DGSnmV9FS8A99pQMxcBrAHbZhuc2Xegda9WtPXZNj/ScNhLX/jqeP8hqymdEwQV9JcE5
         lSDyK1oP8o7KpeCNDA3ecppp5cCwdRVbzY5hlNjOb6mYelyV3y+Xf1a0kLhyQkQ3l+Mq
         YCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862588; x=1742467388;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/wMjl7Q/J6WQRlQUTRmWAqcrf0d7pU34h1ehg31lfI=;
        b=SagmW9DOgpdWDuva5JbSdvlKogvQQkhT5ZULqUOpZ67bHA51PdEzhUih3Pkx0Z7VWB
         GLbuvwbxXbdqCnj39VoLOnvmpZtncwYXlv/XDAWaBfL4HyDtedoFp3ooDKC1ZpWXQQZp
         P+5BHvzmqkCytFwX+eDFxEpSZg4Rs/nT9xe4mHKPy4u1K7JFxMfQc3/SJvAUggpRqdAK
         C661mHaTrT22tgsEiit5EIeHZ5ma1qQL5CVKCmr94uqU6TVOZFQi8EGWqRUpwbvBvH5o
         FQh6USkJpknRbT3+hv2HzgKs3E/nEn9QypT8AiYt5OEl+3Z6AWO2bbA5X0FnTmPnWCTG
         mHLw==
X-Forwarded-Encrypted: i=1; AJvYcCVUdI4Xs9f43OM1jGUs/4pUU1T4clDWHBnlIehQ9MHfAZZfB9D/exwC9JYOWXm2aNLv2Qc+ygzwOqkW@vger.kernel.org, AJvYcCVZHlS85wulFgboQDI3xVO1BfvCGa/hQPOtcHtPQFat2Bz2NTXEZTemd93uHnuZfSNfSQs8WL5MTM2CbWTX@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYpFJ20FUeAwBK/66owlg45UTzAz5kA4HxmR7w8FGPuyrxflg
	aqYfkU5UxmmTj9te40UzbNBb/5XuvNQLINdfgl61dPWDjqlYIigO
X-Gm-Gg: ASbGncvtFYluNQCsEIzgoBfrCQYu6InXaDsRLBgQz9MKll6Ovni2wJ/TJ5js2JpFqsO
	5cvWaXRO7fdOkGZKwA7vkpzbw2Eubmzi2VytnpY6S+E433R7O75HDJBfSyoSUh/wzG6BJQoCw4t
	8MHtLEebGYPOCqTl2lP9JF9avkFUpbbYhlkNVw+H/D5eiXpvtlhhlwJqhS+sQhGnGZO6gsTaB6g
	r+hMRvfBPPHk8rl1RtJqgujW9MlfPLlGN6smOw5DY+S2irD0I4TOYOz93X2t7cYhBwg39IOydEo
	x+wpVTJzrkBiWYNmtKRa0OWk/Q4E1WhfTY7UGSxz/O0vCU2kzPEVmVDEwnQhPSHmYZeLfGXRrwh
	9irxN+f3UgS/WKz6J2+wEm+CXfg==
X-Google-Smtp-Source: AGHT+IHlgJ/0Zq8LGAbC0JM1shbR97v6kXIu61cyy2+LFvXoplbiFx6QsyXJl8Y+G3l47+Ic+J7RIw==
X-Received: by 2002:a05:6402:2347:b0:5e7:c42e:3cc0 with SMTP id 4fb4d7f45d1cf-5e7c42e3d2fmr6212085a12.9.1741862588162;
        Thu, 13 Mar 2025 03:43:08 -0700 (PDT)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afdfd0sm598994a12.75.2025.03.13.03.43.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Mar 2025 03:43:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v2 2/7] drm/bridge: synopsys: Add DW DPTX Controller
 support library
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
X-Priority: 3
In-Reply-To: <381bbdeb.342.1958ce2b7f8.Coremail.andyshrk@163.com>
Date: Thu, 13 Mar 2025 11:42:54 +0100
Cc: heiko@sntech.de,
 neil.armstrong@linaro.org,
 sebastian.reichel@collabora.com,
 lumag@kernel.org,
 devicetree@vger.kernel.org,
 hjc@rock-chips.com,
 mripard@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 yubing.zhang@rock-chips.com,
 dri-devel@lists.freedesktop.org,
 Andy Yan <andy.yan@rock-chips.com>,
 krzk+dt@kernel.org,
 robh@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE66F347-431A-45E1-8764-06767B7FC74E@gmail.com>
References: <20250312104214.525242-1-andyshrk@163.com>
 <20250312104214.525242-3-andyshrk@163.com>
 <61E9B36C-8568-4C0E-A9A7-07FF612912AA@gmail.com>
 <381bbdeb.342.1958ce2b7f8.Coremail.andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
13 mar 2025, o godz. 01:23:
>=20
>=20
> Hi Piotr,
> =E5=9C=A8 2025-03-12 22:23:15=EF=BC=8C"Piotr Oniszczuk" =
<piotr.oniszczuk@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> This series still  based on Linux 6.14 rc4.
>=20
> Did you apply the three dependency patch mentioned in my cover letter?

Thx!
I noticed =
https://lore.kernel.org/linux-rockchip/20250302115257.188774-1-andyshrk@16=
3.com/ was missing
Sorry for false alarm.
Now v2 works ok for me on rock5a and rock5itx
=20=

