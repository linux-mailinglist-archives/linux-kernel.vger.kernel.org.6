Return-Path: <linux-kernel+bounces-186350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 569CD8CC311
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885041C21A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722F1411FE;
	Wed, 22 May 2024 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nEQvlhj8"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328391DA24
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387498; cv=none; b=V/g6eMurzWKDMzdovScdknVAQFMzYEvoasPmM24fZY2m34nl93bXufsykT/1hpq05wHkWlSEtdAzoI0E6mQvSxz/3LIsrnXe4IcDWMgSq/61b7fwuIIqOpS6Eq4RvHs76ldwaGMSy93okEbuINJYKdS9rARIlPlrMiEWdW4EksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387498; c=relaxed/simple;
	bh=XdGM7udhh/rDsOmgLCtOfwv28+UMTcF99TQmI59z2UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSDSn7j6yq/NxBePmsTrnS2DOLG4qA86npPWbjQZ0/pnTnS07+loVdWrE+1v9KubFCe8GTQOO+Q6cM6UduNuiATr02SwmlkoEz5Pc/Yf8U/jPSIF86hRnzJ8dsJU/poPbeR7eNXBFxQVoFsR6kgACNEQRhv8nbhYuMvidxWXwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nEQvlhj8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b782287f9so6190886d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716387495; x=1716992295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp4KP5oH7k3Z3p5mvwLefK8v+H6XRCcOVGolKaP/uaw=;
        b=nEQvlhj8jZY6u1Q1x00jN8K1I0ChTLgxLdEk22g/m7sySVzqVsuemxNGdJOOYJu9/X
         FFSqfs5iVPJMxp8L6YSsh0ayCbUzaq48tTWaifLmJ9wgt6wiBkDTS8R0sB4OzqFluof+
         EXl47E6QvSySSSlLBNsalK89w6IefT90tOGnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716387495; x=1716992295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tp4KP5oH7k3Z3p5mvwLefK8v+H6XRCcOVGolKaP/uaw=;
        b=Nq9f20Yym4O1cJ/Lh6Dx+u2SaeM6B+Q3j5aegxnngZmMs0FE673PFivodkCYXA14X0
         5awuRkOYgpW8J3jDQKUgaUiUmNb9EqCfEh0xD9dtDo+vJ65YwkXnfajj5fvRpw5An9+B
         42apeXvzgz/qGsmiNGX5xy4Vz4HrbVMsITxnNy/CDOxsxY1mTIyEFER0Vp1K7S/wk9wV
         TZpA7S319ITSM86pCmZSDtXmDMGiDMQjnvSnpx/OVq0TF7fWMvfEDXoNauK6CqWyl8/M
         HTtPhWw9gqFdFZaTIUOLm9VOhOCFAsP3GtKZ4miaIyremJrFBw6frq6Qsvg+bGBFvQN/
         DHhw==
X-Forwarded-Encrypted: i=1; AJvYcCXkKPbrpHvVuiMOJUcPjUByHfDVRTDJwbJtvTKmO1GFr8Oc+o+XK4SV/0bboLBNDrNL1hqmhd9zpTzYAYqD84KYtu0fFDk80tpjPomD
X-Gm-Message-State: AOJu0YxrCE7Gausi2jysfv7ihrMSLrj9g+A+9YGo0bjDKt+AsNc1VSIJ
	jIMAZhzYHMOxITHH9VLNRUGOGfki58M3IqfgKbzVQZ88uyj66y9pXjIlJNyR7vHY1QVIQzCyj/Y
	=
X-Google-Smtp-Source: AGHT+IHl61uEnz8iNyNARifRFaHoFORFQ8pOn4mi1RHTXqMJruLKeHKvkrg7u+NEv4S9tm3nZA9rFg==
X-Received: by 2002:a05:6214:2d41:b0:6ab:7088:c0d4 with SMTP id 6a1803df08f44-6ab7f349909mr19196036d6.12.1716387495367;
        Wed, 22 May 2024 07:18:15 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab891a7697sm3449546d6.107.2024.05.22.07.18.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 07:18:14 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43f87dd6866so369761cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:18:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdndfslt9wrLUnM2ugJe6lg1tLJ3g/aC0WoIROn7iYIyidqaWyvNLzppZU9h554GlrTq4zq6gjtYbnceSppE2x05Mr0LeCGrHYygLo
X-Received: by 2002:a05:622a:5a97:b0:43a:b187:6a7 with SMTP id
 d75a77b69052e-43f9d3de508mr3824681cf.28.1716387494000; Wed, 22 May 2024
 07:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522113924.1261683-1-zhouhaikun5@huaqin.corp-partner.google.com>
In-Reply-To: <20240522113924.1261683-1-zhouhaikun5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 May 2024 07:17:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XruLcUq+4Y=tpVKREt3zeO5pjyzP-SH91ghJR8rfWZCQ@mail.gmail.com>
Message-ID: <CAD=FV=XruLcUq+4Y=tpVKREt3zeO5pjyzP-SH91ghJR8rfWZCQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add CMN N116BCJ-EAK
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	daniel@ffwll.ch, airlied@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 22, 2024 at 4:39=E2=80=AFAM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> Add support for the CMN N116BCJ-EAK, place the raw EDID here for
> subsequent reference.
> 00 ff ff ff ff ff ff 00 0d ae 60 11 00 00 00 00
> 04 22 01 04 95 1a 0e 78 02 67 75 98 59 53 90 27
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 30 20
> a6 00 00 90 10 00 00 18 00 00 00 fe 00 4e 31 31
> 36 42 43 4a 2d 45 41 4b 0a 20 00 00 00 fe 00 43
> 4d 4e 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> 00 4e 31 31 36 42 43 4a 2d 45 41 4b 0a 20 00 98
>
> Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

..pushing to drm-misc-next...

