Return-Path: <linux-kernel+bounces-523765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD63DA3DAF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99553B98FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2DF1F8670;
	Thu, 20 Feb 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C+R/Hau2"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529D1F7911
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056975; cv=none; b=H7eFzttCxILbodjIez0lP3jtxvngh7/7sb6bXnN825vChet7Szf/cum26KUhg4eEa/bckSISZanCPXZBX8aPOMzeUUHe64MheSghVQw648kpDa8VKrKWJuypR7AkUpDKp8F2pBkjA0lyjvIBIl1cAzWhRDWatcHI3E1uhqbntgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056975; c=relaxed/simple;
	bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6i1UrR8jdgQn8g42eDDKtK6fQVNjfrwFq2Ubfjv3nSpW8tUzqPuLGc8Y8NgO4eQ9XSA6625WZI4vYGtoqUslFm2zeDfFKGNcHNyfX6XFDDs7p2tYxJvx/5NbcHDHV4imOMSjOVhJz1quN5496vz7Of6XDn9BIg1WIPMYzpqvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C+R/Hau2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbc38adeb1so163570666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740056970; x=1740661770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
        b=C+R/Hau2g+pBGqJmjAtbmtdL4dsKHvh6W7yvQnKEdbklRIwFMFGdYGhITZMoWdp/3v
         T1XbuvI1Ii71umHss37hwhdik1dlBn7Da8j4n0Rj9iiiHEIFgRwrrUAFPKDfimtm/Tiw
         EmtVGn5CMNJ8V68pMFv4F8tsCO2YOh1cSRKHUYXOnGP5Cm4cjKeDMkdgbBe5zkRej0QQ
         G+cB0eZxXc/RTvXLGu748Tflpv15LVix8Fik43Fsg+LowGVYwwUImusgeh5lPcVJqufh
         gnctRt3OjZWL5bgd5y4llre2YSRXbTUzNsRKm/cdRNjyuyljn9TMJYCrKw/UGh36wo2k
         a50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056970; x=1740661770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=659Z5MgEmFp3Njkp+0t+ptDcYZt275fHIOylgA3dWnI=;
        b=El5OBCh9LmLx75SDApPOJ/jwXzKJEXYUoE9wsDMG1iExF5vZyh5/ErBjTHDgkAmjrH
         0e5o18hyUjuCxrsuYHb2nWaUih9edViwZh3CzGjIW9VeKrzXIb4vSl7DfnX6yWHwGMYx
         LHLmusA1P64OngcFmfD+3UY1rRcwmU4NbPoF+5cTkjFZLbyxsdASng3vTzDKExVuSLtp
         8uswGXECwD/wR0I8XmsOPqj5gCbiqhjrymLm9qGEoo5Tig8GOG7AZLsL6vzqph+yJZEA
         7BGu/zgorccT8g5jvK7ZkjvtwjUcLtQFBjirKSiQLZK0RQu2i6i1t9Jck/clWgJrOsAY
         kq0w==
X-Forwarded-Encrypted: i=1; AJvYcCUbhhi2cWpXqO9OrXuPuP8ocNb9iOIDrmKCi8aKHxsr/OxxACZn9AoQzJ2MoRbTNAI+9F8sFH+VBSH/bqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrPHlNz/kVvVvoY6gA4J49n+T59MqvBtKhrB793TO2QWaBnVM
	wkPbMGPP3RuLp7R40v8MPrcOnB1QKVP9f9kVGg+t9muEnItSKA4BF+Lonxp1p18J3x9bV7ZPx90
	7OME9m+2jrcCmIunmB5GYvSy+yyxVkjETwFnldg==
X-Gm-Gg: ASbGnctzEwjpwo7tODnonHIvB9Ix5A3l1aW1VXUFbxvcu19hajBs+NLBmoGA380m3mW
	9ztQG539dwh+E1FxYD54N3fIqiLHLauH74QHjhYHQ7hwqzW3tA7h2g8cBZiE86Ie8fM1i2JU7Iw
	oEWPCjtsjQFtjYscr52Y2Pkp5H6g==
X-Google-Smtp-Source: AGHT+IGPoX+5794U07EydT48UEKhGOyMUOF2FtzKyULbqoGRP0V32LcSKq9unFMC783mM102XE9wLcWd7UMwvlaZCoY=
X-Received: by 2002:a17:906:dc90:b0:ab7:86af:9e19 with SMTP id
 a640c23a62f3a-abbcd05a611mr799771966b.43.1740056969659; Thu, 20 Feb 2025
 05:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
In-Reply-To: <3978045.1739537266@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Feb 2025 14:09:17 +0100
X-Gm-Features: AWEUYZmpP9P0Gfh3rezBjkEnKqpCWeO7xkkWonrM0Uq7UsX6pZI6C3FwpwtpoBk
Message-ID: <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:47=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>

Greg, you merged my other two netfs fixes into 6.13.3, but omitted
this one. Did you miss it, or was there another reason?

