Return-Path: <linux-kernel+bounces-514983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A1CA35E50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A749174AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6504266EF7;
	Fri, 14 Feb 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Cr4XXrGs"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36B266EF3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537897; cv=none; b=ekFh2Yf/lq8PtcIyIGF/ecX0mWHRf7JmltTzt3DaqP5sdxoZ5BMJCuocAoedXuqdWuchBruUFHaqbogCnLyqq/PngifS5mM9icpaldVD3mdHCRwjuaOZ1LY3iSVZuKRepQUp7Wq5KcbmDGqpYV44nBALYQ65wP+4DFSMKZMo1HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537897; c=relaxed/simple;
	bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDSm/+F/J0PqtL71CXs0T/J8awHFOACfX/4Ws7zUMWeHgdxmuLvksSytfcrryU9/katJ9JSnbPPLCo/fi+rbDJYROvHbtKD5vVLJyfENC8S0NvNaQFFWxBMnQhhGBJF126daHm/P/sMxCqJQ77SvBHTzlCk7LNIvFXUvMQqyj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Cr4XXrGs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so1983616a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739537892; x=1740142692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
        b=Cr4XXrGsfnSJkI4egEnIi4Qm36HM1/pM2XXGocSHMBy7dRQR2U9nGtAhtmQkGXnTD8
         045IxGVkJ1blxDk0cxjAg47Y/MXPCr7nHKkPrMHtT/OeGoc3qeyjX2nezhHuzl6qYSeh
         ULhgfa1QkX5q5Am+8nq3TbIkEOiat+f/8g81eYYp8dcXstfgisVdRCA/Ah5ttF3Zxs88
         J4vlBdJ2JkQCVUxzbHsoJEF22geGcY6RBQQgqPW/Uj31SYEK61TwolGwKkmPQchJx5u6
         9TGu7x1zMzbwp/ymfQN0+4Vp/Y0eJBMWX9HegzjpR6dPpGQj1nKRJCHytEuXG+2v9wgx
         OggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537892; x=1740142692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
        b=pbWL7K/2VDRCNotf7OjiYJ2SRb2naQn3Iqt7tp9++Vp82xuyiPMYfAddGRMEvS8ppS
         GVC+og9wDeqnOr5hbdYm/6Ja/Y+RxqxbFfS6eOzOaFFrbhBL+aYMfSYNZlexbD1pc1Ai
         bH9pZyHE+5eJBeoC4pn3vCcuXJy4brqAaKgsC3sKJGGbE3UwCuo6I/UB4fs1Z7Gy322P
         QMZ9UV7ehkA23BHWkKhd2SzVU2Ytu221bOEZcPNciddxqve8t0iBOM9HayRsjUY0q6+s
         VdL0c2ztX+E/YWuB7RBKwMuv3t+UiF4twQbwHJWo8JJzmaV7Ohb1c1Y59eFHhfDsqBzs
         nnRw==
X-Forwarded-Encrypted: i=1; AJvYcCUcXLk/inCnuuqPoUiBQu3CeZ7UbOVCqMEfVsLCJrH/ufEY5lBJRxhwm9Q0MtkxcN1nndiEJGTqtEQVrZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7V79W9T9d+6niOUdN5cej6MAJae6fkk9bXejgFTyqC1w8phZ7
	hiXeIZIJNHMO5AYeurnwZTbUJ5627Q8B1t3okAUoQ1S4CkOjHOOwFDRDY9XkFRhHtuudCzYmMVD
	WigXF8hIogv9oCxiChUOWPfq3M1f2ZorAWNVAt+84MXa72dzGvoE=
X-Gm-Gg: ASbGncvn4AhA4i6wLufoVo/86wh7X0vk/SLGaJjlR0SVFQbDhJtTR+pRmGCqlKeZdjh
	d6yNIH4BZUuOnBHRUOUKnx1guPbIf1x/NibQtC7k8Kq0gIqrQKzzlqyF586lEQVNM4eTtUBce6o
	aP0hRHec9VaH89ZxF1QW7wFsuPNQ==
X-Google-Smtp-Source: AGHT+IHLe7+YddvwF1jEwniu619wHEGtN11Tr41dYTgRyswr/oDOoR/sEJkfGEC7KAtiD2iVWAPopvcxL2FDqAZcQrg=
X-Received: by 2002:a05:6402:2387:b0:5de:db71:3c56 with SMTP id
 4fb4d7f45d1cf-5dedb713c8bmr5113028a12.20.1739537892171; Fri, 14 Feb 2025
 04:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211093432.3524035-1-max.kellermann@ionos.com> <3978182.1739537619@warthog.procyon.org.uk>
In-Reply-To: <3978182.1739537619@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Feb 2025 13:57:59 +0100
X-Gm-Features: AWEUYZmPI7kPTw9KjZhYB07W4f8cfJRiru9zF2iZKyu1QvSWQCmjZ0cvWlpS8mI
Message-ID: <CAKPOu+_6v4Dc59CHOTpP0PuzY3hie=nCUjw0WNBTwiHzCRc=Nw@mail.gmail.com>
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:53=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks David.
By the way, we have been running 6.13.2 with these 3 patches on dozens
of production servers since I submitted them. All netfs problems that
had been haunting us since 6.10 are gone. No more crashes, for the
first time since last summer.

