Return-Path: <linux-kernel+bounces-437149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93269E8FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A307282C75
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6221660D;
	Mon,  9 Dec 2024 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOBzPojp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9E21570B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738769; cv=none; b=JvqySml9FLxdDuedE6kUgMswFOPnrQeg7QfxmLif3JiRNtEWXJ/NoKRc1iMyUqrfSnu4gxFu8XBYqr999OQym6c7cPHM21bqV+MYtMnT1ZCIt/aM5v6+DSYJkd4o3kvzYZsyAVjoIp9c6jUhaip3v+UE28WSbsPE+3kzmkU9B+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738769; c=relaxed/simple;
	bh=/LJlxxkuxafc63Wd1bi4UU+iQoIDb9QxMs9b6JJz8hQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GvZckCpVnnJlG9KXD45ekWcliwuix/RgdU9jWZkblL62nm1K/YdrXZSH2X+d41lFnMZPIQIGEuxIrru93GuOUoPHI9TyhaeLguZoAFfKrZEjxV8N39f1At2Jrdq9BtnxBaKa0Zzxm8Xwpo2nYtnkU6yDF8JhkoRTNAko/FMwZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOBzPojp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434f094c636so8348825e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733738766; x=1734343566; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LJlxxkuxafc63Wd1bi4UU+iQoIDb9QxMs9b6JJz8hQ=;
        b=HOBzPojp3ZD1huZ3EJKekpDzGQk8HG8IJGKVWHcRE6AidUjTcFcENE07Xd7VjLorn8
         5B90C6lseTDnpadr8+Vuy/kXY/GkJAz8SCsAIXod6PAKc2NnfxbNcln/keqohgPNrAhc
         TxixAlQ9X/m8gOyKZGnmnHgUzk2Va1J12TmBtcYEViVznNjv+Glt8WcP5ceJUwb7PTSK
         kD7hWG7Lb4eeYpsDI+g6PK5i9+z6O8c8JAEMsjJf0uBX014I2XMfcIhv272LFDjs5U1N
         nRMJzoHo6I9gIxLhbhMAwWPDiWnrGGsnceM+OdIx2MZnkGB3DAH9HRdQWuYISSozOrGF
         PpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738766; x=1734343566;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LJlxxkuxafc63Wd1bi4UU+iQoIDb9QxMs9b6JJz8hQ=;
        b=hMaK93z48zY4vRFGxYLgWh5Xkb1nw3l769A0REt3UznO/AbCw8ICM63cmrL7KZJDXf
         Vb0ahyJCVsMXXH9xzuNZOqwNqhJoUlacfa7yXJQX/jLWUdLOmL0X9dQ+XSmLg5d/8p1t
         UVxmrhrH0cIboUoLjkI5DbufcKhC8KnvGaonafQWTBsP5cnxzG5G47ChshKzzg32OPYJ
         uyBLk+yQntWAzDBx6vgB0AkK2z3d17cqMmsTl5F+69oVAbTdHSpN9F1106vwHJrhO6U3
         flZk8ORIaEcqqs2wESgxHSLGmaXbKcDTEgDSVgOEk2iYQze8uNEtQPxNTbvjcPJuqNn9
         nEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0SAyyc5WPOTQkVPVhQmaUU8d+5mAw2EufcJ+bcmM8+45JFJ4xcofKvGsAHMZIFqlfq1kV0OG/fyF8xCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/iEXbO7UUnL3M30LrZ53cnwScLKNXSYBt/ab98jXwA+8hQ2G
	7bNi2j5yU1Nnao2Em4ZbSa0hXVM6yX2dxEEYQRYggEQq0NSg0W39SqOUdJWs/tw=
X-Gm-Gg: ASbGncs9GDMIoXPgjnnsDDkSzzgpTe3l+LLY0Cy1miOitexdHKLcVweEqasQGJ92NyQ
	ZG2Yi5TJFtTN08tBzDr8rZrXBPrg1T5UE6A68HD6zasS4N5BiieFewcljsRYm7snNeAvlTY3RE2
	2dFXw2X2khY6ChXebvnXHVLwyabz7Ivl15c2u0iskRiDBJVjpcDq006U5qdhhIwazmyMPsQ56dj
	CirxbjPA5J2W+Tj2GLRssFPFmithHcdvbtuVb9u9LXo18NhWvhNqQ==
X-Google-Smtp-Source: AGHT+IGJPbrzOuK2a05dvm0F4dtdPq0Y/T2pAGQw1YzQ1ka2ok+Y6aOk+x+gp+whelzTQDnBCo2xjA==
X-Received: by 2002:a05:600c:4fc9:b0:434:a529:3b87 with SMTP id 5b1f17b1804b1-434ddeb53b9mr109539965e9.10.1733738766502;
        Mon, 09 Dec 2024 02:06:06 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f19023d1sm64250965e9.20.2024.12.09.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:06:06 -0800 (PST)
Message-ID: <cac8862fff16a9f1d4ba59371a226759ad9b71cb.camel@linaro.org>
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: fix error code in
 max_contaminant_read_resistance_kohm()
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>, Badhri Jagan Sridharan
	 <badhri@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Date: Mon, 09 Dec 2024 10:06:05 +0000
In-Reply-To: <f1bf3768-419e-40dd-989c-f7f455d6c824@stanley.mountain>
References: <f1bf3768-419e-40dd-989c-f7f455d6c824@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-06 at 16:09 +0300, Dan Carpenter wrote:
> If max_contaminant_read_adc_mv() fails, then return the error code.=C2=A0=
 Don't
> return zero.
>=20
> Fixes: 02b332a06397 ("usb: typec: maxim_contaminant: Implement check_cont=
aminant callback")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


