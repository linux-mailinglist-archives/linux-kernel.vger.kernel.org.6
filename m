Return-Path: <linux-kernel+bounces-411954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F289D01B7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D321F238C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25585946C;
	Sun, 17 Nov 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BraRK5ye"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000828FF
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803068; cv=none; b=jZnjRsuMDUjw5acIo7uJBxHBWVKKfYf7fW5gpw7zI93FsCsRUH1eNnX4KCWlFSMse7WTgClFIwEn8tUh4nfVpHlcdyXqRK6XIMhgaK+Q6xJ9qTpjcv4y7vymdL3lUkZNrFktX/+R6HyLZ+wxJVtpdCRWF6R4cWvpLG9iDonMk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803068; c=relaxed/simple;
	bh=ocQ0r7pmqpzv4lz5D1G/M4lBGf0YM0OQHNOLD6yFJo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGGEQkPD3x8sBGq6sp6w7LqZ8pu/tkxkCkkLnfPD/yB+pdIu98U0wfBS3QMASzhN/XKxiE1zHjcmKlBqRGo+z8oTtLyqrjQIhhdig/wc5czA72+DSa/AUlpA7sgYIcCtqZqwiYEKqJ9GREOIx0LB87neQh3c7EBs1rn3Oy4mFpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BraRK5ye; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a68480164so437334866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731803065; x=1732407865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LX0zVUghvJRcc4ljKP7D+f24RyfwSYfXIKzndmlZIkk=;
        b=BraRK5yeTcvN96+eOvf7p/2PcLRvIf1+NNtLiZi15s5vfG7SF7apeDK8PVcF1rHeoh
         ctHGt9JeqfZ1J3h6+Cc4WYne+xhsfCbETmiTOFEnngbCZeRc/1MLoWAnASrU+qS+zGhi
         hRhUTepfDcoHHgz0zNMbD7ISqG5zvh6A/qxGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731803065; x=1732407865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LX0zVUghvJRcc4ljKP7D+f24RyfwSYfXIKzndmlZIkk=;
        b=TbD1sEWl4XMj2MlRqTKHrt4USq/xYatnL0Lnd9z6IknwTV/6HjPjsMXtj6f8Rb/tdK
         be0FjPq4tq3wSfCyqRg3iIBY1Z2z1GHg/qbHS7/+XDYU4wfW0scUJIUmu4ILvAQD/7Sw
         o9h1p0/dYNKEJnZ1My7+YoN2c/hYs67NIb1r1UswRMz5tlREFkAmiRx3gHqA2sYmD8KV
         IOPB1FoJ8kh+i7SXa5KhPg8AK6/KpALHOfXGvohzjiZajvHUhLZ75/6weMcF60AXw9ze
         1+cwBm4vhfKkO07qaFCssN5rO4M91CZ4dFSVKsVFFTK3tvBxOD+PsSE3hWPQeMcGMglB
         BvzA==
X-Forwarded-Encrypted: i=1; AJvYcCVkKMbbH3ZwYHu2HAei3O3sUwr/sFQotnOrBoDmswzGHesgkl6vyLhBmfbbB5e86PETymkXehQrZbrYR4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdk4DjY1PljVZzZ/yMhwuhHMO7xvVbSlomvhFBvSo4PGNyTNo
	cbghxlm/EOuajAdL3qwc9sOzrpYpKiwyK8pEDpWzb5G39FCsSr7TrRAC2dah5sx76D/vGxLbKkB
	NKk9CvQ==
X-Google-Smtp-Source: AGHT+IGBtIuKyz2sa5n+u5ThINPilBNZgkK9x5eTu6WFAyUFIjG1SN8VvyMDqWdCNat58ci2DdmkIw==
X-Received: by 2002:a17:907:3d86:b0:a9a:14fc:44a2 with SMTP id a640c23a62f3a-aa483488086mr702402666b.30.1731803064973;
        Sat, 16 Nov 2024 16:24:24 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e044bb8sm359051466b.150.2024.11.16.16.24.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 16:24:23 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa4833e9c44so267880566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:24:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2+RiU4Ih9li8ZjXrxDr1tyyQdoloqIMHPouAjgVZLOYkX+wm+y2MOagPtVumSbeH7BhAvRq0anx/AL28=@vger.kernel.org
X-Received: by 2002:a17:907:3f03:b0:a9a:a891:b43e with SMTP id
 a640c23a62f3a-aa483555ef6mr716497666b.50.1731803062330; Sat, 16 Nov 2024
 16:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116153556.767f1aeed6ac628a09efe346@linux-foundation.org> <CAHk-=wji0ErHJjX-ZE4fdQ02nxcqQa5pwV==1sHC3p91wxUXAA@mail.gmail.com>
In-Reply-To: <CAHk-=wji0ErHJjX-ZE4fdQ02nxcqQa5pwV==1sHC3p91wxUXAA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Nov 2024 16:24:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1T_JvBcn_gqFdnuENA-Y9EL=2WNhN5o2xY3p3h4TPMw@mail.gmail.com>
Message-ID: <CAHk-=wj1T_JvBcn_gqFdnuENA-Y9EL=2WNhN5o2xY3p3h4TPMw@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.12
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Nov 2024 at 16:17, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I can see the original at [..]

That should have been

    https://lkml.kernel.org/20241112171655.1662670-1-motiejus@jakstys.lt

of course. The link was the wrong one.

            Linus

