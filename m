Return-Path: <linux-kernel+bounces-192121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A468D18A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC99B284193
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A04716ABEA;
	Tue, 28 May 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VRfbWyuf"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EA15DBCE
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892491; cv=none; b=ppQNgjMD+Eu6bZLfbUg7qn2qeTbn6MBPJPQgKCoJy+P5upsccBhzK5lfxBMdsWn5cdWNqysUaD04M555EEgGI2COUPF/vdtrdS/XGT02qwpUifptgdQZkXXkAsIoivnkkPbyYoL4gKnA1fYEp+0nRDRoCg8dHcq9masnT/1/qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892491; c=relaxed/simple;
	bh=rMIZmynHxQlTJRn0wXZDXuqK/c1wUSB5d1m9RwF0rDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESoJL8JY+NyAChA1KWGcBW/9rekHCsbkZ4Jq/w4Liy8L22fGW7AkfOJS7ZSXz9MKtipmEsTKaBEiV/J7Gsc8RsR36E4cUo/KKUCv+0EmaV66goYUx1ONJFSIp+7tVw33CDznvkreD4Jun89AwB4d/rpKEWl9SC8+ftyOsW3e6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VRfbWyuf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6265d48ec3so70176066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716892488; x=1717497288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rMIZmynHxQlTJRn0wXZDXuqK/c1wUSB5d1m9RwF0rDE=;
        b=VRfbWyufqqK5ZZsb1lGQI2YarBtNiVxgRz3DDwAUB3bgbojF3tGCj4eDQlSQcRGMa7
         //mLg3qsOEKJ4Zhdmp/gySnVXkA4o4Ln/7D4pIJYBGPOS99VUye86v/j5mJnmB0Giq93
         5TmRTRf1NnJ/LmeYzyoTDPk/kRftCDdITZTe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716892488; x=1717497288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMIZmynHxQlTJRn0wXZDXuqK/c1wUSB5d1m9RwF0rDE=;
        b=a2FUoAdbJ0Hm9Ae09d5uV4D8mbxYkPD4HYGaGPC46MldxmkwWUiuFonPKkhoG+6EIV
         5g/j7krP1HKJYIJpl5K50TzQTIl8MNgcw9B2MhQHP7klMpUm7gSQ9AspbbdCJ1w9TCrE
         Wy79dxNCSrCwzAhoUYerHJGq43zkfeuupYxVC4YoGBuRrOXNLgkk8XnAI4dvnYl5dQsz
         HXlupBbO7NGjcII78kz5/h6oVLoCGQVn7ju4aMfZ8LjCv/Y84iTku2A4eWkMztcJOsyx
         3uPb0ZiL1DpoinMExzlgj7nnXhdY3oKNN0B1dQKkTvAV0rKUohJQoD/4i+ZGh+wHJWhb
         m+aw==
X-Forwarded-Encrypted: i=1; AJvYcCXAMwT5fQ1FC7mHPWHHrMBmFyLZB+8ycaQvdPGcVoNYvlt/wzpv7phOvu69+3+Qx3s5Z8dpBG3Z3P09qoTewNWNlxV13dHaK0X1l7PP
X-Gm-Message-State: AOJu0YzRTdt7qjJiTqzeHD1AWE2+6tZVVQARv0WfVHmZ7vIh1pOKXgWh
	VRVu/tJwlSvOnSVR+D2ebuqMaDFva9Edshn7Y88fxJYI7oZGJTOdOQWwoY08/DiB1FWCnoR/lIH
	nnklnuz3HWcyARfw3CaMGNZmNojIkPEzGZLsXXw==
X-Google-Smtp-Source: AGHT+IGf3ZtXXEh5OYJF07HdIQPyKNgiGwm/AnMlXGcrV6HD0/oxru+8FNRPGNaNU9NPkpCQBGpav3hf5+9QEkM2STU=
X-Received: by 2002:a17:906:6b1b:b0:a5a:84c8:7710 with SMTP id
 a640c23a62f3a-a6264f00dd2mr877227366b.55.1716892487943; Tue, 28 May 2024
 03:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528090244.6746-1-ecurtin@redhat.com>
In-Reply-To: <20240528090244.6746-1-ecurtin@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 May 2024 12:34:36 +0200
Message-ID: <CAJfpegvoao1jd7HhoPEeWCdS8jWEXhKTENbwvLdo=aMiNaLKQQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: change error message to info for empty lowerdir
To: Eric Curtin <ecurtin@redhat.com>
Cc: "open list:OVERLAY FILESYSTEM" <linux-unionfs@vger.kernel.org>, Alexander Larsson <alexl@redhat.com>, 
	Wei Wang <weiwang@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 11:03, Eric Curtin <ecurtin@redhat.com> wrote:
>
> In some deployments, an empty lowerdir is not considered an error.

I don't think this can be triggered in upstream kernel and can be
removed completely.

Or do you have a reproducer?

Thanks,
Miklos

