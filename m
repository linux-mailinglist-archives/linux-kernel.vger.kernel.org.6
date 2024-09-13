Return-Path: <linux-kernel+bounces-328753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFE797884E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171C8285DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7E613CA95;
	Fri, 13 Sep 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Nj2u3n25"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F043F12CDBE
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254000; cv=none; b=VzIEntFBo1A4ssVBfv1lqi1x+lLybcfMwSOJuwk9+3vUHiPCljpwpfZMAWLd+Kbwyhk+ff0JACHOzDib95rwtWkM/fJOBfVIdEZMQ11sCEBNOWztNtcCvB8uX2lz9mVYvPFAyB6c2GBwx5Rd5TXqiNvMP8JmFsh9r2dCegd9AWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254000; c=relaxed/simple;
	bh=wpbv/Ypn1S1uipLA2hFz9FfiEnh9Vqi4qgnntowCZ2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD52fGgpOZ9BikJH6TU5IOU+35fIx1WFVJuoTfwfuvKhHrROY5vzh5tihbfyGbChm0cGkusfxRuE7CC8k/u0/0EJMmzRoU3ukgAG6yZBatb+Hr/WytOKA/BK0xbt+xaoJXl7/DsBienMPJYjJoTve0CERLV/RaaThH+qzsi0IEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Nj2u3n25; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 278713F68D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726253996;
	bh=wpbv/Ypn1S1uipLA2hFz9FfiEnh9Vqi4qgnntowCZ2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Nj2u3n25/6Sq3nR61jAxdGJ948PuoNGz0F5lUNBzITSw9JRIEs/vK5iuYnzNwjpc3
	 Vy0QCoLs8FbYvmgOOOyGY1Omo9cFIU352AZOH61pZ7XMPvFCFpv1yIVmZgkc8evCjZ
	 pcIK9IOuwuLA4HJZsY7IpYUIS5OFyXHEzK18raJmp2Bi3i5b+qCDgntmpt/vm6/BMv
	 Fbg+wIo+0orsHh/Id9bY0iUYRwcBRF9r2PqiqEzMgBQfQwWnzDSYdw/LYTUC/3vMhf
	 i6kkyFaT29PAGMHnv+xsxAZ0T37hmBMwSQKrouzwL/VMu9NSNI/tmJppZg5RtYIVLw
	 upjm1hqmGXhMg==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f759688580so17055931fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253995; x=1726858795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpbv/Ypn1S1uipLA2hFz9FfiEnh9Vqi4qgnntowCZ2Y=;
        b=bPB8iaW7mWFWqbCIch3RO0KKYE5DWPEXVFOY+9QNRX9fPTMRHpKkaGFJjdH46Z5uE6
         HgRCgmVDQDAml5ozaqlyof/h5ifNLJNW+mhCEdSgss0+kgFDVXb1OWkkp/NriX/88ojT
         RXUBj8o6swDOmuyX32f4FB3jz14pB90UuWxC3aimYVcDXeDrr+onTQweGVAfUbkgldFL
         Nz2hdlfRmfNONY0IrXxlf1slnnigVMTDBmryD9B4rEY2wo2UHDNAS008lKZhKVS/tbLv
         6UHQNR4bQ9FUIFrTVjHV8bUTsWJ/DOKS9BdkO1USPn0Avs5mmfAk88I0rjgU4ajiGce1
         jkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6AOSK+8Ku4QgF6gKTaiF/9dSPr7vGpLOfSvHkvH+Q4u95dWbhSSB+s1rfZlVB/tZsq1G37kSm05mWPkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAO1lNG103lQQYagt30vOl2OXefMS+1/DtmhzG/YtHWg3cZGb
	jLjiNB6jaMmO6TGnq5sUonn7RT8x2MRC2omLyUGgs3zjHvJDKLEOHm7mw1ia31mfFWXPp4nXfXq
	1dCsd4w4PZphawaW5yChbjhLUbEl3a4Sh9FzVXYhwt+t/JsmWw29mvJxwCDMCbSq28ZZWDWUZXl
	EAo1fQKdOSB2MlJtOgfNmodqgMOduXrCAh+TqDD1XWnMzrpV5bPXWO
X-Received: by 2002:a2e:b8ca:0:b0:2f6:484d:cd61 with SMTP id 38308e7fff4ca-2f787f508aemr42687751fa.43.1726253995200;
        Fri, 13 Sep 2024 11:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLGUYMl89leAKfovfViroUdG1wecKCCAwr+u+OV4SS3394qQeK3Zw8qJCRvMCI/rodniz94xbgppjljrQqRg0=
X-Received: by 2002:a2e:b8ca:0:b0:2f6:484d:cd61 with SMTP id
 38308e7fff4ca-2f787f508aemr42687431fa.43.1726253994147; Fri, 13 Sep 2024
 11:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
 <20240913115124.2011ed88@kernel.org>
In-Reply-To: <20240913115124.2011ed88@kernel.org>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Fri, 13 Sep 2024 13:59:43 -0500
Message-ID: <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Sorry, I missed that you identified the test case.

All good!

I will still plan to turn the reproducer for this bug into its own
regression test. I think there would still be value in having an
individual case that can more reliably trigger this specific issue.

Thanks,

On Fri, Sep 13, 2024 at 1:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 13 Sep 2024 08:45:22 -0500 Mitchell Augustin wrote:
> > Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
> > trigger the pmtu_ipv6_ipv6_exception sub-case
>
> Sorry, I missed that you identified the test case.
> The split of the test is quite tangential, then.



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering
Email:mitchell.augustin@canonical.com
Location:Illinois, United States of America


canonical.com
ubuntu.com

