Return-Path: <linux-kernel+bounces-262615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831C793C997
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B64B1F218C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A39013C69E;
	Thu, 25 Jul 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YTYFMZ3c"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B466376E0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939705; cv=none; b=OVZQEnQyx1jSAwcVO6nohUGH9snsVh0ZdtQwkJL9ANG1R+vErrhQd6zLsUoQe8uCGxKHOjxda2j1alaJ94nMS9opJ+a8sgZRFut4ZmzQM12KTCm6LRBmgDE1/Vk7O2ux4kWH9YQmaAHZ1tz/YfoJIhqKTNllgOG7t/mjDovcwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939705; c=relaxed/simple;
	bh=+hcuACSrDnXuyK+3nXy13Q6NsIAr/YWO+OR5khRNjm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSXVNGS64oAq4gEVBkeHp0j0ykOUIS8mD8ZuoKJJ3NWG13uFqJP5aVk4DAmR4874Q4kaugRXBdFtTPmSauuaqEE+psh1RPsv5N43ePtBR1/1s1VD4E3hwz2JXIOZ6OYRKmprlzsAk4MacI/hc2sbwRmdTp0+z5hxBby5pM+jM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YTYFMZ3c; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efc89dbedso760840e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721939702; x=1722544502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTSgE8O7VMPCTD7fk8+6qaxrJiw/VS+rTSm4VMUyc2M=;
        b=YTYFMZ3c3gf56lfxm869KK+1IESMInS+OqGssJpHdDdLTeQ8xqPHG9J+zmu/GhYT0g
         Fv8vQesdQHkSO7b2ndGAvltDJyZMi05WiVWZ+fnSmEDnRUs8Rd6ah353W77R1IHf6Xg0
         dwvDCZc04nfEQkHHYbpe0QtbknW8nSKIx/A/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939702; x=1722544502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTSgE8O7VMPCTD7fk8+6qaxrJiw/VS+rTSm4VMUyc2M=;
        b=BzjBA0s5qVLBn71QktqconrPBIfFvhWbbhSDmsoMQQhe1aMDg7dVulASW5Ox4Q7zmb
         Mqf44RJVRNb/rNeYEDoY39vdKuZmJD1e9kfSRk0Psyl7wtasXyIx4cDRkSm7asF2GKNk
         zD0kQqO06x1Jtl5uwzeu+RY8imfD2UrRTT2rizXrkl595CUypHW5HBIq8B12qL8mjCOs
         osElqjV3anzLmA8yG9o9rzjOLDBhpIk2iAQYmmQJCOw2fmNSX/Ze0jOeaKLDEmnlsdpl
         zJQeOGAnG0YvmlwZ2nHpHy6/zqGVBFUg3g3ZLTnrldth/ZbrYkcNwJyKnMMhie8GH/YK
         J8IA==
X-Forwarded-Encrypted: i=1; AJvYcCXdYn1LPeGR/5ip8L2h5HjzzieekDtMmuP2IPFkzQu1o4vNp+8D/yDQbgSPc+19+m9vDyonHSKHKZVjLQC9oHIwCDe70PUufjpHWxIF
X-Gm-Message-State: AOJu0Yz6Pj8lHBJr6BwC378m7gs1HM2xktZTSdtMtWRWcvcwzuxSrSiw
	ebnQHOTP7xnVaJYTCN9lHFl97IMz032UCZH8gLqv7eMKLUY+oBqH/W9Y4XK4PFOIjLbzivireLh
	r2F8=
X-Google-Smtp-Source: AGHT+IE8xx2B/X3jQHA3+2MFcoeV7jtuK75/QNHNzLGGD9UMwtby44mJ39DC94eCO89FJSjIi6zn4Q==
X-Received: by 2002:a05:6512:124f:b0:52e:9b15:1c60 with SMTP id 2adb3069b0e04-52fd60f4ec7mr2332200e87.48.1721939702045;
        Thu, 25 Jul 2024 13:35:02 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd0bf6sm320455e87.67.2024.07.25.13.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:35:01 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f032cb782dso6019921fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:35:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJaZKWHeQY7j1zC3v0O4rEawC+SC6NGmH1/wva4IwG7g+sf+DXLhZr4wWmXLM1BuIdd+LgjOaxR9G6lo7VKJyQCiLTJ0IVt5GEaP2B
X-Received: by 2002:a2e:91c9:0:b0:2ef:2c20:e061 with SMTP id
 38308e7fff4ca-2f03db8e45amr23043301fa.22.1721939700903; Thu, 25 Jul 2024
 13:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725153035.808889-1-kuba@kernel.org>
In-Reply-To: <20240725153035.808889-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:34:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeA5O8i629FHxHmrk=5WtD41cA67paUNBxMH1ooFBgFA@mail.gmail.com>
Message-ID: <CAHk-=wjeA5O8i629FHxHmrk=5WtD41cA67paUNBxMH1ooFBgFA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.11-rc1
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 08:30, Jakub Kicinski <kuba@kernel.org> wrote:
>
> A lot of networking people were at a conference last week, busy
> catching COVID, so relatively short PR.

.. and here I was blaming people being on vacation. How very insensitive of me,

              Linus

