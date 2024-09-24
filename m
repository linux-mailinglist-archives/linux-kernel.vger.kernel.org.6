Return-Path: <linux-kernel+bounces-337719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33212984DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D152D1F23D85
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7314C5AF;
	Tue, 24 Sep 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7YHtNnD"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D91474A5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217542; cv=none; b=CLAAZ8bVeJh50a4Jqe8FKUBRjdJ5OH4FnEz3O3Z8JkmoKEH9+1dBNMF7iuo6ToEoaIXVAf6Fi3N8gTDuB5Aev99ojGCiqqSM8agoedH9bPQvbXHvqIC+YDhXGS9sHg5N+bacTfOCpfPuZxU/iphpMlyeuz78z7/JTx3ev4GY+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217542; c=relaxed/simple;
	bh=P21AItCoKiaYhlaVKxc5PH58Wxm4G3DTMn4x42eHVlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6gnPClNgCVd3HCNWqaZlcsSG0VFfIbbOn47XAZFNa4yU6OKOah8t2wL3sbkKeF5J/WVj6Job1xcEMs7LMEegcOR6YQ5+u9OC27TOqmMCzcvYmspmGPjXMB3fJwC0HOxJ5vCSldlWm5azZU913fD8kcvjt1CMnbNJj/MFFvnZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7YHtNnD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71829963767so951031b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727217540; x=1727822340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P21AItCoKiaYhlaVKxc5PH58Wxm4G3DTMn4x42eHVlc=;
        b=I7YHtNnDDlXxJID6XOPNg/2Uo6Sg/eborQawsjpT0abc6/Wu2+XjWi1OlJoOd6dpI9
         mrRYJaAw394wDTGEWnZNUQ+mbTbaXDyRWGdOBYJVIzl7cuP6BUPbIsFmdOjcAnNZtJRK
         7ztyL5EyZ5GIKIsEVfNAnRpfbjNCUnA7Xo1E8UCF+afzNGd2RwSpg8XwB8OAshjNq+ex
         l6qDNDtGuzwXX9c40kibiViWuINT3XKG7X8Zt8SpFHHbmW1dL5wc3uJXtKuBYf/6rMMu
         KyG6ErWtpOQOEzJ/+BbpSIxupQaqPooHH3RoZUykB2Xb/EH+2uZjGZWY890BgNsbFTW0
         hDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727217540; x=1727822340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P21AItCoKiaYhlaVKxc5PH58Wxm4G3DTMn4x42eHVlc=;
        b=lKKdubxbQetC/dmSdBnKkYQoJP+W6QPC9f00SSJAAliRFCW93q+reJh0wSIhhcIMmd
         en0i6ITHSQ2XH070861X0R1oga/zViJWpTkK1wV70QYVvajOFmJJM1ecpxn817iT2dle
         +SsiBI2c0QOMOH+Kh1weF0tKr7256eLdwkNjEJaMKw1XB0fy4sMNL6yFT0RmdO1FDZZL
         k/WNE1ebHCn4qq2XnzdGIAkas8aGZP7BfD+uGbPJyu0DthveSuLovR4vVNzv62295G74
         csKRLW2Nx1xh11e80kBawfg9y8zMz2FS4fixoqR5hsIRHMf1DOScootwUqh6V0tL97Zn
         OhRA==
X-Forwarded-Encrypted: i=1; AJvYcCUk0CwWGOVISzhysD1HfnCnWCxDhRCNBhBWCUnPryCq+i5uleSlpg6QxMYw3GBNruVHfWPgHHq0/UFMX+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhd0JUh4Pdx6aUOA00T/wZPS99iWVRtKIIniJrQTUw7S86qVXF
	jQxHS7lWAgcXqIk7TmPI/Njvf6JfWy+sKhyZ10luQBYqB3NzKngUZ951qOofntctXxD0tH7ZLI4
	+P6zZS20sOPqgPUkELr0TAcRiPQM3qGn4
X-Google-Smtp-Source: AGHT+IE3bH8FpFNNkgcUcPjSAhYuGOsUnrpyQtX392ba2Wpa9AgsNT16Q03OVa5R1FWCSZEFew1QxzRRLOmPvSG2HVA=
X-Received: by 2002:a05:6a20:3943:b0:1cf:672e:cf08 with SMTP id
 adf61e73a8af0-1d4d4b99541mr508482637.8.1727217540224; Tue, 24 Sep 2024
 15:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924223210.204379-1-ojeda@kernel.org>
In-Reply-To: <20240924223210.204379-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Sep 2024 00:38:47 +0200
Message-ID: <CANiq72kjszZWKzyEztNTN5Qeq9RBHZ8UC_VjEwUZ462Z0ug47g@mail.gmail.com>
Subject: Re: [GIT PULL] clang-format for 6.12
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 12:32=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> All the commits have been in -next for a month. No conflicts expected.

That was meant to say "two months", sorry.

Cheers,
Miguel

