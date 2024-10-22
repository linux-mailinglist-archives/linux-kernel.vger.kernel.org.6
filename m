Return-Path: <linux-kernel+bounces-377108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24A9AB9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A18628481E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99F1CCEEF;
	Tue, 22 Oct 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QLT2qyqR"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4818593C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639012; cv=none; b=VHJFGVrL/AeAFJ70ZhCaNyZHSXu4O/mSRmRom2i1dieBoJrs8BJOcCOFNE0mFg/zJRow29xh+BWg5mTs/7bKz1TF7YQDlUOumHK0QGlTrFaL8cOalh37E9k17/XbLSFzYnPq8HrQdvWiYwTDb7xmmcIvNfEaHRTWdxdAZPDIo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639012; c=relaxed/simple;
	bh=OrdoYE0Q6ccQ44C/5I5oLyobBWb5jRhLx3nEH7xAUMA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=K8/U76DjhKHu38GH8YWNRGlBvwNhQx4Ymbgi16xuLxuW/rbci7vCy//hKeMu8Rl2kqdYDej/JmpM64+iIIsvLFII1PdO/nN3siXHnN4odNvHS7m8dcaGkwchRtWSNYFnv9I7PfJnGmdHFVipYoWTlcBt3H/CanxYikoufZPZXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QLT2qyqR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609c96b2e5so36987171cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729639010; x=1730243810; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdRK3yhTYghtJWmdnw+e7xLJLXdLknBEqJe/TDxy7I0=;
        b=QLT2qyqRlnLc1udGb/GgyXkMYbCGuaktvcNdSGJffZUg5jwk30sqCZlxF3tFa090Tv
         kjFyGiZMn5uL61oXUarJsACH8ihIIXYx+3qmEyzNWQzAtPc6z851GOyo1drCmeGJgNHd
         W6U3FF6YRwA6D5sBusLZU+ISbyhSFVKylnuxQaoLXSOIEKAcL/5/V9pvUWxV1i04fGnB
         jrcsgsS+Vnd3Zcx44zI2VlLj/aaYcDZ7qmYRHrM7v+q4/RXM0wZiVH46tST+ZxL7Zm5a
         KqGYDSKho7CaBDSvAoZ5W9uQIqH272ZCYhSZ0mjA6GgcG7+4uMqKh2hmRO0JdTkPgWFy
         cuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729639010; x=1730243810;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VdRK3yhTYghtJWmdnw+e7xLJLXdLknBEqJe/TDxy7I0=;
        b=eSzA+DcTaHz8xiGLhqJ8t3dola8/yzv4hYT8L3Yn/v0lPjaJhgaKhIKfha7pXC22SC
         jJi4xXUoWvTUMlQ9NB/9LZ1N+zsueqoAGPkpwbPihoX7byMCmyvXV0dmDx/pM3FclSRn
         LUIa7G1+VtyqBkh05Y52WNOHg6lVGBbk4SC23dgqOV9pLHKT4yQJpTuc1Zn9RSIyqRE5
         L3Dj151U8gC2mF/YdECC7YgqWAErIz4fs+cZUMVCwNRcIKJSRVR9lhKZJrbYsnuUHXHM
         hSoaKCZmWV34k9Itj2d8YNSmftVmc2HI2NOh19MWHq4az/hovTKmFEmbp6qm+e8jfMWp
         hP8w==
X-Forwarded-Encrypted: i=1; AJvYcCUFucwWieBU07A0+uZ3VKuWYwmDlKzHyEPa0FS+BUg0an00xkO/7O3bSTwq3BoZxG/9sehgIY8peZBIJ0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUPP2lL2L7A2qCxxQSvKweGcTPMHeCmLSV6hcP032gdMGbtLe
	elw+8p083c3ZbuCsM+TYfqbSPSpPLowuU53Mi7kWAESYVYvXn9Sas7jzbLOa+Q==
X-Google-Smtp-Source: AGHT+IHude/EQvEBYN74MFczuaEQlg2V7f2joS40qCBs1gJ13F8yauj8PlOv2uTO8PItNO8JHZluzg==
X-Received: by 2002:ac8:5987:0:b0:460:b165:2e04 with SMTP id d75a77b69052e-461145a91cemr8312401cf.4.1729639009793;
        Tue, 22 Oct 2024 16:16:49 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461167a39acsm767531cf.32.2024.10.22.16.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 16:16:49 -0700 (PDT)
Date: Tue, 22 Oct 2024 19:16:48 -0400
Message-ID: <83794297935bea8af10384deaa9c5986@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241022_1912/pstg-lib:20241022_1830/pstg-pwork:20241022_1912
From: Paul Moore <paul@paul-moore.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] audit: Use str_yes_no() helper function
References: <20241018110945.111842-3-thorsten.blum@linux.dev>
In-Reply-To: <20241018110945.111842-3-thorsten.blum@linux.dev>

On Oct 18, 2024 Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> Remove hard-coded strings by using the helper function str_yes_no().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/auditsc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com

