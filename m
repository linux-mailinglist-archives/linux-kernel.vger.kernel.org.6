Return-Path: <linux-kernel+bounces-330001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBF8979852
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FF21C213F2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7AD1C9EC3;
	Sun, 15 Sep 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FGL4+8IX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCE175AD;
	Sun, 15 Sep 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726427001; cv=none; b=eGSsuvlL27gUqXBAS+i6wy3JUcrsA1q+It3CGmLbLdEPE4CikaW8UKd1FG7WFuGjXFGfWAaUTN2v0KA4H8rCxuOVK73ltdCB+jZ8dfZC7a5IZSJT79vg1Z92rdz3lFNR4lFgYfVyuM7dmQqafZEscJbdcq0e238S7KywxUuR8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726427001; c=relaxed/simple;
	bh=q5h6c/YvAP1zhZ3/e123DERCW4j9bZxrt7p2p+WIsLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHE065tKXC9pbvqJ3okq9bywfk14rXiQMs7tS0SssIZvrmRY2xP9m4ZNFiMGxyhLUfW7KcnFBCVop/CKhN14lqmWHB+AO/6BmylOBWB5VgZ9e9DAuOq3uauUzXafzXDDg5mUZmmJTAama7GBCHUsPteoamHiMieMMHXsxgOCS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FGL4+8IX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206bd1c6ccdso22631655ad.3;
        Sun, 15 Sep 2024 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726427000; x=1727031800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jJyScG3d9NHQ5S4X3PfMPGGWweIlWR9sQ4K9rWSPFE=;
        b=FGL4+8IXaUwtmlx4ZINdG6PeNTuuk7WlWDc+jDF5X4WgoegXeo9JtDNXePjor13Eul
         GMDJg4P5CescoqMrhX2LJQg3xVi0Yb9uSEiici9sWKiC5H8KNG/JT3HH0T+uRh1XplQe
         4SCxGh3UUXlumLkXgaAYEXmFwPo+Ot0BtUxZq9NMkXjsn//b/Jf9alfhnzYTcVild60a
         MGbbZKsAUTDqaFtfq6+Xp/sUhUqdSop1g48zSL9yor7btRvCL3MDgbVj9h4+wRdgGONO
         m+tkwfbygL5EqnVp+zDqr558PB1Sb5FornbFvYwJ/LXV3QAmC7CX4r8KG7fPy1kVMpXu
         nlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726427000; x=1727031800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jJyScG3d9NHQ5S4X3PfMPGGWweIlWR9sQ4K9rWSPFE=;
        b=Hzh8GjUnPJTRXUESFjO86gaaFDAhxfS6MxNT1rKBA+7Mxytv1pplOfoSSzqzLUStCA
         Ox6HqO4mNHTpwYQ4VyknGUXI0c/uiYBFp239OmjxL17LXKF4RvcUv5bJm5co1I8Q3pY3
         Ze/UEhtX2vWPRNgAmzosZo5Qk5KOTTM/6nksCwv3b05K7N6J6d/ovD9kXgs0OePY3Out
         AeOp1FncGGRRT62ubAeCAm00ozGbUnxKKOs2LICHmmPxHneIV53xh+VNQ3bm/ePTmkMa
         PVsrOx0Me3WVodJXLi25+tBFx/5aG10wDk61ZIMMCjprhM71o9Yb3HYoKX7EaG1WAN8X
         Nq5g==
X-Forwarded-Encrypted: i=1; AJvYcCW2nU+qazoiL3b2s0pAXOo71UblqbWoZVNTx97Q6XaVbrFbSxXx+Un8wCIXi411fqJwS6lnteqQs7TXz2rQ@vger.kernel.org, AJvYcCWi+9RwnqAc6FJlrSVNRTuL7x4ufPJ8AdVXwDJoXnsX2a0Bbq0NUXseJgjG7Ka1fy/SLz44BwaEbwd6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdxz6LSYpPxZK9o4RPnqOba0k2/G/MQszSNNFylLSTg78A6bt/
	GMT57mW03S7EFBfFDnwri3prQ73PP9WJhjxMWE6QgvOSXQQZLpde4CvDKMuEljYZGEGKP8GBS4L
	Zn/dscHO6MTGxegJLE8ar7KDTviw=
X-Google-Smtp-Source: AGHT+IEZ6GCkzKAWLZZHHU7eMS2eyq+j9CTeJLAwZNxO0mhFJtwQEHrrljy0vbXUZx2OkSpdfzy+QX7A9REB1jTMkmE=
X-Received: by 2002:a17:902:d58c:b0:207:2093:99bb with SMTP id
 d9443c01a7336-20782529c52mr108597785ad.31.1726426999543; Sun, 15 Sep 2024
 12:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
 <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-7-feaabb45916b@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-7-feaabb45916b@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:03:08 +0200
Message-ID: <CAFBinCDe-yhHja=KMjAr6-EigOWipTCZZ0ETT9QttuOOBFX+kw@mail.gmail.com>
Subject: Re: [PATCH 7/7] ARM: dts: amlogic: meson8: use correct pinctrl bank
 node name
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:19=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Use the proper name for the pinctrl bank subnode, fixing:
> pinctrl@9880: Unevaluated properties are not allowed ('banks@80b0', 'bank=
s@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b=
0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', 'banks@80b0', '=
banks@80b0', 'banks@80b0', 'banks@80b0', 'reg', 'reg' were unexpected)
>         from schema $id: http://devicetree.org/schemas/pinctrl/amlogic,me=
son8-pinctrl-cbus.yaml#
> pinctrl@84: Unevaluated properties are not allowed ('ao-bank@14', 'ao-ban=
k@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14'=
, 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao-bank@14', 'ao=
-bank@14', 'ao-bank@14', 'ao-bank@14', 'reg', 'reg' were unexpected)
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

