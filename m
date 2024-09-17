Return-Path: <linux-kernel+bounces-331449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE5A97AD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33DE1C218A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74938157485;
	Tue, 17 Sep 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AYY4d2e5"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1B15358F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562798; cv=none; b=YL/mHXFWxgZ1/EpDVjVhlj9C0HFOs6gONL/92ijFfzUDhxzWBjrbbNcU7ATkZ924RRO1kQp2TM4FgMMhar+YT/R1CVNjZ9Kju+MIcqyPC4ZTOK0yqLaVTPmVHfeuAbBz7EPnJ3/a1Kux4QO4/+BOGC3bkxewUaAdbSEJESK0RW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562798; c=relaxed/simple;
	bh=q1SqqmO8f69Y4yUq+LzrOIV4DyLPY/LiTuSL0c6FXvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBvvt+kL5KHKyJyZb2LZOmm4kd88MPAudJaVRYPBYSfGl8sWlMo82s9IqHfarLWpxNxlbq/jwoYH9uHhFEvR2AWExE/z9XgCq4crIV1eimpO4RgweRSPvJpWSQq6kQy0OepknDnoCvkx4D/1wwqhxxrRpJHqKRKuFFHAJa0Koak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AYY4d2e5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so5986799e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726562794; x=1727167594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJBhudlylQx20T8DaheWHIktldjYtmdayChYHIL8RnQ=;
        b=AYY4d2e5zC97LAp4U/h/YsWExNtuwCoYRl8JNns6yIxX+qDgKCeKCG5BuzD6QPESea
         aMEDCUh5wtUQRj+991BnTon8JCNRrk3NOVShiTO+zgqAyq3NMdisXuah9NNM+zfFm9Zh
         nRG4u2BaXubM79jTPtrGR6f167CPqIlCWqTOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726562794; x=1727167594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJBhudlylQx20T8DaheWHIktldjYtmdayChYHIL8RnQ=;
        b=LxXux2MED7PmM4AbYR4q/ijcrzlU6ofKpMV5UXVcZ4iojOM+TkT+Iz13InNC0NNlHL
         NUR93BjjEMgRIzbAEJaWOWvI8DP2BLpDVOMNjrckzvUElvKlJmUQ6Oik/dnO17/BkK+1
         XPwGyBOx0Om7IJKs6jpVmM8ibHjXrAw8zb41Vdnw5s1E749cbR1JnMzRrz/QX1A2KONv
         sPHxxh61wO3O0IBmVf1g4aw8W/URE44LtzDtGHpLqfhFOta7MTLTUcfgWg6PmYRkYmM2
         mB0S8FjD3ng78Asa8QXVNNu/P6aEgYIBOXdiLk9idC4oAuEaOSsNxReAzuuf9UPChaNF
         adag==
X-Forwarded-Encrypted: i=1; AJvYcCVZGoSzqpeW5xjjAm8Q/TyeRRfV5ykP9niDZnpO9e/QhyUj346/G97G3GfS7pU3eADJ5RXv59/e4KKq5eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qKnhu7oT/efbO/bOQ1bD9ZMAGBRN15WSVvJAPGiA3kQHaIaa
	CCGI0iTYwbZcro3wZaFL2Q00AjzsKe58T1o8GmuXgP5mMUw44dhmyPbUleD/hKykcHp05oMVCTi
	xtNFw+A==
X-Google-Smtp-Source: AGHT+IFrcbjAUfRtKng2mQ65mtl4Es6q9+wPPK94KKN4Nc+4929DM7+48jla3zQ3Wni3JiRZsxy44A==
X-Received: by 2002:a05:6512:1056:b0:536:52da:5183 with SMTP id 2adb3069b0e04-53678fc1f1bmr8740830e87.18.1726562794093;
        Tue, 17 Sep 2024 01:46:34 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870968b1sm1124054e87.153.2024.09.17.01.46.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 01:46:33 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f762de00e5so60148841fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:46:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL9+2tMuyRGwNI9EtVTw4y2gTC3GddVzjor2ynKIFL+G3mDQnYTmy1EKO2L5Mz57eyh7eVlxfx1enmOFE=@vger.kernel.org
X-Received: by 2002:a05:651c:b06:b0:2f3:fae3:83a7 with SMTP id
 38308e7fff4ca-2f787f58477mr91757961fa.43.1726562792876; Tue, 17 Sep 2024
 01:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a40b4b3a-5d61-4bef-b367-745ba058be9e@app.fastmail.com> <212ba952-faee-42f8-959d-c2a8d3dc89a7@app.fastmail.com>
In-Reply-To: <212ba952-faee-42f8-959d-c2a8d3dc89a7@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Sep 2024 10:46:15 +0200
X-Gmail-Original-Message-ID: <CAHk-=wh3C2F3aO+Ky8CUQDM7+tUSxkCRRCVcLH+yuhaLoao=vg@mail.gmail.com>
Message-ID: <CAHk-=wh3C2F3aO+Ky8CUQDM7+tUSxkCRRCVcLH+yuhaLoao=vg@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] soc: devicetree updates for 6.12
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 18:32, Arnd Bergmann <arnd@arndb.de> wrote:
>
> soc: devicetree updates for 6.12

Yes, the diffstat is large, but I'd still have liked to see it as part
of the pull request...

Your other pull requests do seem to have it, but this was missing it.

            Linus

