Return-Path: <linux-kernel+bounces-300000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F107195DD6C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C4E1F224EC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753E9155757;
	Sat, 24 Aug 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEwD9w2Y"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAA28DB3
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724496640; cv=none; b=jf1gM6fM80XHonPuhcrTMcU6Kua8BTZJcm+EDitU+ESDhSyNj23cnot8BfCl4CgM8mKSu7xzYGESxAamIcsxhtBE80wkNI6kWkR0BEhDMZ0uHv/iDv2OUSxJVcZ9nfTJ4WJYWRDIqhXVOVM3ulfG6s7LLpUvjO50GoPGWgEEhhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724496640; c=relaxed/simple;
	bh=MyT6pHbI74MEsYBsc27CNATHZS7slYAB1sweCEtW72c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bRByOh2KcWAzZeqYSlT0sm6FabR6vihcuysacTILBj0w29+0Wx0PiLFh5GNZyfghhOdahdmdiJHgHKojW5uhBojEveBZ67KM9ibSOKGqc5W3MMisilOT3awNy4g2XJDxuxI4qLkehxA+TBaa1GPNIc+zYINb+U40MTMdK1Cygx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEwD9w2Y; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3f68dd44bso32565991fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724496637; x=1725101437; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyT6pHbI74MEsYBsc27CNATHZS7slYAB1sweCEtW72c=;
        b=DEwD9w2Y9yfbtcjB9rDCH4j4DBRyQmmRCUF3crhZRcipUUloRlKMMZlp2X9JKPHPyZ
         GRCkW+V9PqSEnTR1i8fAbV00TmrrkZ8h+/WyFrW71deHQWtVWXOBnZVVmIx28R9ow947
         XzC4bTeU7JiZHfBXFBs7mtOAUuK8jiFlh4tq1Jc2IX29fJssEh5xdgx1xucKQfO+/z3S
         yQb+vMclVfWDVKi6npUEIEz7iteMogIIAo7UP5Dez8w99bRUusXWKtjAs3SWOHWapmNv
         aamloxGJkg9QKEV8pYZVk+VtqY9aFF1DUVaCaEnRYxdvXDlCWNeOf2/nptV4GlEZ7rL6
         DPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724496637; x=1725101437;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyT6pHbI74MEsYBsc27CNATHZS7slYAB1sweCEtW72c=;
        b=tARhW+Z51DstoqYB5LPpu7KK0iMRYsE6ksEOTdHHsfpZeC86HmbckA7nsbwNZCpCmp
         cNe8auvxabOCaPgid6uZpMVunLYd4khDY1Eq9z8hpfvzlcG0cOvYsZ7ys4wcL+onmcad
         sjsrokJGcscNJXwcV4xKMlx1a+7xGBf/58ORLHWxSaW/PAyJegpRhMCLQox+VzjToFMO
         j8BYEMMj7Z/MG0XGtacFkNLkt9LdwOY+s99VGnSpMtku0961nzV4nlN8VV8VPXf+9MFA
         wuX1a7P2QYf1NTDETspCWnzftAke+rfVTyi4rqZNmZl0ZaMKEYECyYHVhIbKYk3rxXYi
         GGxw==
X-Forwarded-Encrypted: i=1; AJvYcCVwjZ6jdFy9N8FxxP2wQOjNgynE0AfsQwSswxv839JL+2xpUf3Q2ZbT+azxU0GMqoqxIed151fyYouojXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKqMjouGO2VFq26Xu2kanlzoHNJoZAPEyNLSUZ0sf9dWCZLcA
	IFmvvHhu5I7tnf56pNWeYwjTTRuF6jmVYHgieoly2wKArFrRjJE9
X-Google-Smtp-Source: AGHT+IH7z27af9e+erBfe62AtTcmU6xp64p/FyaP8ui7mikZRWAtcmsm6CH+WS21XHaf83asK1oWEw==
X-Received: by 2002:a2e:7c08:0:b0:2f3:f1cf:5313 with SMTP id 38308e7fff4ca-2f4f490f115mr28736991fa.24.1724496636817;
        Sat, 24 Aug 2024 03:50:36 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f40487fc23sm7101391fa.122.2024.08.24.03.50.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2024 03:50:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAKEwX=MZo4qTED6gtQYSGxgY6CBJYREhgbhTOqvsjhnFt7YwdA@mail.gmail.com>
Date: Sat, 24 Aug 2024 12:50:24 +0200
Cc: Matthew Wilcox <willy@infradead.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED949A5F-1CBC-48DA-9377-48B2B2ADF9EF@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <9793DBCA-13F4-4B47-AD57-12A62F7DD8DD@gmail.com>
 <CAKEwX=MZo4qTED6gtQYSGxgY6CBJYREhgbhTOqvsjhnFt7YwdA@mail.gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Nhat Pham <nphamcs@gmail.com> w =
dniu 23.08.2024, o godz. 20:06:
>=20
> Could you do:
>=20
> grep . /sys/module/zswap/parameters/*


Here it is:

/sys/module/zswap/parameters/accept_threshold_percent:90
/sys/module/zswap/parameters/compressor:lz4
/sys/module/zswap/parameters/enabled:Y
/sys/module/zswap/parameters/max_pool_percent:20
/sys/module/zswap/parameters/non_same_filled_pages_enabled:Y
/sys/module/zswap/parameters/same_filled_pages_enabled:Y
/sys/module/zswap/parameters/shrinker_enabled:N
/sys/module/zswap/parameters/zpool:z3fold



