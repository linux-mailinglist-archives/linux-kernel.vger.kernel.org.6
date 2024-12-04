Return-Path: <linux-kernel+bounces-431334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA089E3C12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F450169A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059D1F668E;
	Wed,  4 Dec 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpXfkPlJ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A61B5EBC;
	Wed,  4 Dec 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321070; cv=none; b=SF81mG9fUA0yLbr9mxJ52PjHwfOJ1HraSqCQxdAdJ5wepze5E1JpsCMm9ZCY0kz0vJlThq1WdII6rWZQVbiKshFdlnXQi333XIE3520NObpmf6QhdA9Rpmi18IIQflYAQinLaTNG9zCH/8xd8JJtIfuvp+WJXtWYh3hzDw+OtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321070; c=relaxed/simple;
	bh=s4CHI61cGyO9uCDOnUDcHgg/UQt0hTEFe9T5xi2issg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukR9vWzLjaHQdF8R8ykSAcn+pWUm5Al3GmqLpvevuF00ZKLh9wj9WvmLObgcNkbN4to2Cj8Rjbju5Zp+o8WlaGnrHtAXxqvuHyZfTQmzsvDCzV29rRoYsWA6pvT4yv7fI3dLvAf6XdvQiXCL0EOQscdqNML1m4JJJ6r1g8X0qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpXfkPlJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215b13e9ccbso28144365ad.0;
        Wed, 04 Dec 2024 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733321068; x=1733925868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ6W488UpSZ9zqTESI3MOS2htugMVo+fRt4KLQxwejw=;
        b=KpXfkPlJjqSbQxQmUoVxhOYuMDbjMqt1l1loJd7lhIl8Bkf/eNWsBBzqMPSZKHly9Z
         kfHnXJ6GjzgqbiLA6dZZOkv4qyVQ/URGv6IZQVQLY2Ui+pzZ3QOYKxwdXfR1JkKkx2sF
         J/kMwvsLXGzHRzkVRSydse905WP4r2ePqNO4zBBFkVYbvOUgs3ucTuprTa2puKmxj3kM
         HaPeoiPBnXoDUWm2gusHic9dgT3qMhKMwlDutDjG0R0x4mj2XjnGxOMxRlrTVT3kku6o
         MNrfYvy/fvoWmlU9qFsf/u2sA3l3I388bTUHfX18qu1WJMmwLduEaYJynZNRs6Z48K4G
         16hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321068; x=1733925868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ6W488UpSZ9zqTESI3MOS2htugMVo+fRt4KLQxwejw=;
        b=ln9+xGuCs0Kdj+a5v6K0DWqLUEz3S9faGp/RyXVpvYZkz1mn78oR8eenmnbpeno75F
         a8IaZad/2FpZ5/iMtkvtHu/naJUZAf216wdz1pSQ3AkKXjVmU3X6dnVeSOgbeB5/1MVm
         rQVBgWkfqxd0x7wiazfmE1z1Gibwtq+VVmF//s72LFhHMFexeOcAQ21C4P+USkzYbn3U
         Tc8E85bVew6sMRIdMIvGM6U4EoJtz7biHOqAA3u+OFyW8WTAqN6g3srSdlUTtr2RSevc
         upRb6s4qhzLI2wDzrSGU5PNqkgnmn5qcJHFwF+fE3a0i0uHalaaD2803qH2wqC5vD75V
         aopA==
X-Forwarded-Encrypted: i=1; AJvYcCVdMUzlzaz1E21vCDZ3ctiEd9bRmd8aQ7zWXfMiOxdgvnXX2X3LXLMYGY6MFO+MhswJB6pQY78zCx4=@vger.kernel.org, AJvYcCVoQPfdN5ivy3h9O8SuAy9GfEiRiINFamTokYY9i2tlvdjW54hNwKxSadAI6yATdztzJ+i2u94XgPj5FpJy@vger.kernel.org, AJvYcCXe/PjU4mMS8URdJJ7tj58gclORV0mTC2RtutTY8thvLWxJuO91mfxQEEEvF/rHvPyKn8qk9lzf/YDkVok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUUYH2taEIf0wQMY5TSAZ0c8i3lRM+lS0asWfDSacA0Y00jt7
	lEJAdiPm9F4aLAnNhzqkk1RKSjEzMTzJ3bYsJt8VEU3SDzGeAuKJl/MW7w==
X-Gm-Gg: ASbGncsRyGSHf7JcVeX/JpYzwB5m0BbYos97Ppcmek24+pGUMHQyyxgyqYtdrDC5ufu
	QdG9epWUu1vOq7hiPxbjhiV57SMd41JrVKw9/PUwYxsOY+FRXIZIDwt585kjatJ+AiOlVQ9dOfy
	A83l30DG4pVsWGaSrNJnWsX5T3qkgKFTsx1h+p7ldPJkB/Uv8XcSJ7iMGk3LKsKZ3Ol5Avw3rje
	hn2y4Tsdw7EnIp7HUgDHKQZ8iV/10LzdWNKkukcNxVpZagqvECLjQwUgAKvDlE=
X-Google-Smtp-Source: AGHT+IEw7jPgOG3GprWrqz6zUvIF0fxEyxemzmgBb9LTg/emkX4V08QqeiTEqiifHxScitOvNtBh1g==
X-Received: by 2002:a17:902:ce09:b0:215:89ae:fb2d with SMTP id d9443c01a7336-215bd188b5bmr76524875ad.57.1733321067801;
        Wed, 04 Dec 2024 06:04:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215dbe26b32sm11900825ad.61.2024.12.04.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:04:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 4 Dec 2024 06:04:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Li XingYang <yanhuoguifan@gmail.com>
Cc: eugene.shalygin@gmail.com, jdelvare@suse.com, corbet@lwn.net,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
Message-ID: <6f37d75c-3b4f-44de-a5ce-fec3e412ec51@roeck-us.net>
References: <20241201034803.584482-1-yanhuoguifan@gmail.com>
 <20241201034803.584482-3-yanhuoguifan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201034803.584482-3-yanhuoguifan@gmail.com>

On Sun, Dec 01, 2024 at 11:47:45AM +0800, Li XingYang wrote:
> add asus-ec-sensors support on the mainboard TUF GAMING X670E PLUS
> 
> Signed-off-by: Li XingYang <yanhuoguifan@gmail.com>

Applied.

Thanks,
Guenter

