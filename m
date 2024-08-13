Return-Path: <linux-kernel+bounces-284381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC495005A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1412D1C20C67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443CF170A03;
	Tue, 13 Aug 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi3gatKA"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF913B797
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539040; cv=none; b=klj5fDhIxpeQbCjfa2k6dYCDtfIDEZ5rIqY+8rwU77Px5FmWm6MBhjxysFshqWpywtZpPj0fjoNyyHnc/r70DpYiOKtfBaSWRBc0AaeZvllWc7997n3iIDX5wXkMQDEqFMhyUQ18YuFh7f5XOxMDq/F6tLGVnDjp0Q2InFGaOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539040; c=relaxed/simple;
	bh=8RyVeR2vWOKQkN+gObPAjdpPyb5M5WyBCqfnjlaswIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+d4CvEnD+YOh/wQNB82OoNEJgCYHeJHgAUMsV3Pv7HF2uuQi4u7yQzU1iXztd94g01cIN8droy/8Or9iNs47U+yPfMOzSptrRRYo0aKGWYQ0mJ2pj4baZNNNC71aujdSJ1kD1zQu1fC7e6NEZaMrOpSR3ABdY5U8ND/5/1JfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi3gatKA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a263f6439eso3219854a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723539038; x=1724143838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rts6zB0WN8mMRj2VryIEa8o9z99JeetoeSk17QbpEU=;
        b=Hi3gatKALh59OWK4vthcbi+fAzIpXCQ3gXfyWJX+ITbjGWSpevNvKQJFfw8NV8ZLQ0
         rBwRwuNfAjvdEJWAN5ZaS5w9xH+QQoDdTK7912S1D6XuFv3r7dQBVjmysUInJlOFJYHk
         Qs0p6woNLDGLWzHU5yf8zj0JK9kqsQ+IUZ2OrY9DO/R1kXljHHajbZkdj3mnsgjFURHW
         ZG5KVpoclA5TbfV90M1QOR+Pq92EGn7mQdyQz1uQUEml9+s3vzbh68R4O4pN97s7Ckjf
         wS9PcQpKmQ6hGRcyUXzkYcSeiR3HEW+a4688iVbs37UtMoTTOiuXRtLl9fxEOAQldYjd
         US0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539038; x=1724143838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rts6zB0WN8mMRj2VryIEa8o9z99JeetoeSk17QbpEU=;
        b=bRe0lmtR6dCBKpPt7whDkGhUHTE9G5ZZHdINiFea59URRA0oO7icdcHeLwnC7XAt0/
         wETU6XoJulVPFNne/mFznPjd1EGomIDMFqd3jUDjAxCLkfzY22HRGo1zTeNQoS6zjoEk
         Ie3xm/64/hEehfVqNVMqPkjmUIwhm9nh6dsovxU1dyS6yUgF8RFiCTR2dm/02757RUlq
         dXt8raX0zUMtXZYLefHrx6qZClqDtvn5Wfr8m8wZepq0JKp0NTLvcp0vIwGfrSL7rW5r
         +vCpvXP+cmxtvJdWhuBPPMv/B2Etiyz6GwBp4kNsiLispUQsBl3OyN8zaHoHp5e81EhX
         E4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVS2UpZukUUU4TYHWeIbaCUkutk/Yx6gw937vbkSvxVKSBjnagYIIPbzKp8iP0cNnNiAKl6PeOuZ9P4SaiODkQqBHrxPwLWANDIVLI
X-Gm-Message-State: AOJu0YyVQtLGUz1T7KH/3Jz2XWtNk8zZXxOfI57FakCiwa8agv239dZX
	kXnZjkWIQgL8e9TH7hzgcRfzN7RgxVL+0cLgxVO5syoDQBeJazIV
X-Google-Smtp-Source: AGHT+IEsIqbIirAGl7TPh/KDv0TOehaMxpmSPAbGOBplieWhUuKxu1EkWXJmILPBHPmyG8lIOvab5w==
X-Received: by 2002:a05:6a20:9f99:b0:1c4:214c:d885 with SMTP id adf61e73a8af0-1c8d7594063mr3775722637.36.1723539038153;
        Tue, 13 Aug 2024 01:50:38 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:c766:226f:440c:9eab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a9403sm8888895ad.151.2024.08.13.01.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 01:50:37 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: skhan@linuxfoundation.org
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de
Subject: Re: [PATCH v2] gpu: ipu-v3: Add cleanup attribute for prg_node for auto cleanup
Date: Tue, 13 Aug 2024 14:20:31 +0530
Message-Id: <20240813085031.1097134-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2aabc166-bf34-49b3-b938-bbfb0f85e8bb@linuxfoundation.org>
References: <2aabc166-bf34-49b3-b938-bbfb0f85e8bb@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Aug 2024 02:30:54 -0600, Shuah Khan wrote:
> On 8/12/24 13:37, Abhinav Jain wrote:
> > Hello,
> > Can this be kindly reviewed? Thanks.
>
> You removed all the relevant information for people to be able to review the
> patch :)
>
> thanks,
> -- Shuah

Sorry, here is the patch link and I am attaching inlined as well:
https://lore.kernel.org/all/20240704132142.1003887-1-jain.abhinav177@gmail.com/

> Add cleanup attribute for device node prg_node.
> Remove of_node_put for device node prg_node as it is unnecessary now.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
> - PATCH v1:
> https://lore.kernel.org/all/20240702150109.1002065-1-jain.abhinav177@gmail.com/
>
> - Changes since v1:
>  Enhanced the commit description to better suit the work being done
>  as per the feedback in v1
> ---
> drivers/gpu/ipu-v3/ipu-prg.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
> index 729605709955..d1f46bc761ec 100644
> --- a/drivers/gpu/ipu-v3/ipu-prg.c
> +++ b/drivers/gpu/ipu-v3/ipu-prg.c
> @@ -84,8 +84,8 @@ static LIST_HEAD(ipu_prg_list);
>  struct ipu_prg *
>  ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
>  {
> -	struct device_node *prg_node = of_parse_phandle(dev->of_node,
> -							name, 0);
> +	struct device_node *prg_node __free(device_node) =
> +		of_parse_phandle(dev->of_node, name, 0);
> 	struct ipu_prg *prg;
> 
> 	mutex_lock(&ipu_prg_list_mutex);
> @@ -95,14 +95,11 @@ ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
> 			device_link_add(dev, prg->dev,
> 					DL_FLAG_AUTOREMOVE_CONSUMER);
> 			prg->id = ipu_id;
> -			of_node_put(prg_node);
> 			return prg;
> 		}
> 	}
> 	mutex_unlock(&ipu_prg_list_mutex);
> 
> -	of_node_put(prg_node);
> -
>      	return NULL;
>  }
> 
> -- 
> 2.34.1

