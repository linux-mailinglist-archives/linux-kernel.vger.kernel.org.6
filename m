Return-Path: <linux-kernel+bounces-194085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5740F8D3662
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5D51F21E20
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC718130D;
	Wed, 29 May 2024 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Mu5HFaL+"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE01180A9F
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985703; cv=none; b=GJYQ8UmxlAIKirQk+/5MO43nxGq3wSGq689RFFaWkuDxXfINauPWwIn/4W0jMfq1xKJRYxSz65ouQex3FgVgJoPeKqm24GhzGx9EtkEQ5lxVnq5O1Q5lMpyhlLifd4dcgvT4Pjm/6Jj+PQ7M7uoNFBz7n8O1hN38EtdNB6Ht7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985703; c=relaxed/simple;
	bh=ySznY15wnrHBfTkbi5EC9eAvvASJDzWbRIEbP5QWD+s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YpwHFMgaQBhsoU0DDcCMFdlRGmm6/4ZFU60EFcWN0gxlyF0fwcF0JPYCojnECWjmmFeFc8G23eBMDGYs+x39oZK+3Sq2aOsku+iE6huAcpF13moDFY+QrSICbsv8Cw0snf7xiVnB3OGl8VIYKF+zJTb8unBmThYIIQjdteZgIGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Mu5HFaL+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b4fcbf078so473926e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716985700; x=1717590500; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySznY15wnrHBfTkbi5EC9eAvvASJDzWbRIEbP5QWD+s=;
        b=Mu5HFaL+XbDLrI/NqUYLqGXy7E8GuH07LvPvq0mmP4VaTrrXjaIJBJnQ+aRO72F2nx
         1yeZ5bHelP/9OFNMorIYqiuhgR1hgz22s0rW6kx/2yN8LSWdMYhMWX9i07pafLwSSbZT
         s+vE5LmhH2fgLwFWWwNsjl4/V4eZ9poTaqZUcxKxIXbrEL0DmXPS0Z3HJ5BgSnHwnm6s
         kGl5vsf/+/IWDFgPJQO/zt59v8HXAIPqZc7VI5gjWQouTwTGdoeezJmUZGIAIPOXTk+q
         3gEfSzCVBhKdlBx+SWFtqDx1SZmHptPAzMlSFOssyRzpnhM1xNRxzz1EhFDx9+O9+mDu
         wflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985700; x=1717590500;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySznY15wnrHBfTkbi5EC9eAvvASJDzWbRIEbP5QWD+s=;
        b=gOdY1D8lXWIfmr18ujlm7mPS19X6ulBVWgdRAeCCVMBcfRpf40vLejt2v/0/V+6NnI
         zY8x25SywRCviraJL2tP/misvOOglU+jfHc5YlFaKlRnPXHgZkHZp8edmavgpWMzU+mP
         8todSFXxYB8Akag4AHRdeCbV0W0Jkk2WwtsmBFrKZjuFFvwUxuA05jioc8akyy2cKgBg
         wpVMgvGI7Wi0CX7ISv5gF+AAVHmkNz/V1Bq2QtXsNYgk30fqtdKp9+AWD1pwCiNS4DMk
         62cmTanAn4jcdfJ/LhU7itIpFrI+8sSiWzWU3ju8ZcruMMOWynDRQQRpwc5hCW4Xw9PL
         zeww==
X-Forwarded-Encrypted: i=1; AJvYcCWM7weUrgCAjBp7p0d7rLC05NCgW4QVKq63EQUWXHXpP29xRBNiUyQUgZ+oCcuEqnj7nToLA0Oy4xlo36Djc5GSVt4CxhbwN3Lv8K7o
X-Gm-Message-State: AOJu0Yyi/EMLZkpixTqIL6qIoV8qZDqCxys8U/ZNI2AFhccmfqy5x89X
	crJd+9ZkH0/crg5iox5RC6Y2rcPX9WTej5Tq9tr/bk/z4dA/lCP+JXAfuNJADeI=
X-Google-Smtp-Source: AGHT+IFrWAzaE8PQPbS1lHEQsHNbjtPO4EvO4xqjbtrm6Bmcj+RR+5EVYRO2id5/xurwQ7KIt7jVaw==
X-Received: by 2002:a05:6512:1388:b0:51a:c8bb:fcf7 with SMTP id 2adb3069b0e04-5296410a55dmr11510790e87.3.1716985700463;
        Wed, 29 May 2024 05:28:20 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:cd2:ba1a:442b:4269])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bb86bsm8025057a12.97.2024.05.29.05.28.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2024 05:28:20 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net] net: smc91x: Remove commented out code
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <6f596a8bf3f0ff2c498e7b6cf922fa28bd0dbef4.camel@redhat.com>
Date: Wed, 29 May 2024 14:28:08 +0200
Cc: Nicolas Pitre <nico@fluxnic.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Breno Leitao <leitao@debian.org>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CDEA048-9955-4822-ADA7-DE4A5E85383C@toblux.com>
References: <20240527105557.266833-2-thorsten.blum@toblux.com>
 <6f596a8bf3f0ff2c498e7b6cf922fa28bd0dbef4.camel@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 28. May 2024, at 15:36, Paolo Abeni <pabeni@redhat.com> wrote:
> This is net-next material, please re-submit targeting the correct tree
> in the subj prefix.

Hi Paolo, I resubmitted the patch [1] with the correct prefix.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/linux-kernel/20240528160036.404946-2-thorsten.blum=
@toblux.com/=

