Return-Path: <linux-kernel+bounces-250131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F3792F48D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253D61C23161
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB0B1426C;
	Fri, 12 Jul 2024 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANU71uuV"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD9EAFA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756888; cv=none; b=QjA/YZDIqCmkj89uO/36VDWic7GA33TkZ6oiOzI4qqd7f4JfW0xGhEm4lm4bwPUWDqCHa8ED5G0so8agVJ7saDRYkuW9pb4FEMBLD5isd9AbDJbDXjm8/QiBD1hECoqLbbkSOwF0VVeyG5pbfa4HTSkedKhbd8BV0wOgfJ+9uf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756888; c=relaxed/simple;
	bh=Mojd5sLkSsotvYliHkV795WgVUL5ejqPK1/7NuNIJKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILMsDI1lScwL6ZoBUNFfC8P59ST/afiL5r3Ry7r1r+fSJoTEIWHm3nhLWFpBd9tO1BqWvrdVIy5+Pyr/ahNm9oqUUfKSdXrlxCZolMDHe6p9Fsr+EWsbJPahNOpcAiUuAVDpIK3nfTNyhbuIF3BU2t3LmarEypB9sXBLPLet3vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANU71uuV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b13791a5eso1402655b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720756885; x=1721361685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCkh/w566kgosJstul08uhlm7kQC5Dz2jdqdwPBnpoA=;
        b=ANU71uuVdGIzJT1eUTz9ou3F/5OlUDwj+jmR11t+eQ6GH9VeHXd4DRqHJdy4dRW/52
         b/BM1TqZJ0nJJzqZYnw8QXtZitFHl2adjh65Rw5ySyu5I3BfLA3elj1wFbQIqDCyV/Qy
         iUoOdcjWprah0IWEyfGzPwlHdBCZg32QW+EsfgIaodN4pp2hrp1rDi+X6QOO2RoGWpAN
         yDX/a2poNHGCnmDtsKAzBlovxUb2GD2A9FxYoCAbDhP9FBBZNUtk1LoSNX//Zha22tMF
         xM3q+1FX+xYTe5FG8WE00fzwqjHoJhhped0m0aV5vA8Gx3z3THrN/ovRS7RcsfC48ja/
         JGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720756885; x=1721361685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCkh/w566kgosJstul08uhlm7kQC5Dz2jdqdwPBnpoA=;
        b=JZJJFfUHDfrvC5HyQd9Zznms6GgXnL6WvNc1x56+1oWFeUmFeXo6ehjrbQy2TyeabY
         NZAVmiB/5qIZtxDS8NTpVsF7wHZMpgJGxigi3Ztqlkozx+po5TgWAL6/eGjtoNvGIX0X
         ZXKKvMNr4VkZ35ItqAopoaCSjYPDyEEe5cUa076f0yhPTLU386dLfUhaZzL7FKzbCb6H
         ACSxmZXpM/cY5e0C2j/TVjDypZH8Dhav2NhjiZ6SgU6SWGFkQJ6yY4xaQcNMUxUIdMxV
         HUPoG1Rql2KNuJN6BrJk3/MVrGn9p5zk17EyxL5mcpE3DAI2Fq4ltzcIlic8YCO+e8wU
         j+ew==
X-Forwarded-Encrypted: i=1; AJvYcCW/mBtnlh2Jlu1iYEPadgayzcQkBuOvfHowDw+fVV0U8FMcfK1qEOlCnT425kjewNF+fz4R1qnOglv8Ci6iLa0gPq9hb1GnobjFK40O
X-Gm-Message-State: AOJu0Yyzwa1GOQMOGEFlLS0rIQoYoQm+QqmNa4IlFQBHbWPUZO+6qQGw
	GnUANaoTs7qxW6bfQJ29a1jeIeNjjb3/vvC9+RhxLlWIPpBJStPEpbryYiaE4w==
X-Google-Smtp-Source: AGHT+IFRe5L2r0hVJZl1F7hHYzX3y1Ff6ET4IA3m2L6Ah+0T0l0s8O4OHrA++jKyXxtVetBf0K1f8g==
X-Received: by 2002:a05:6a21:6da6:b0:1c2:9487:ee90 with SMTP id adf61e73a8af0-1c2984c9df2mr11885262637.44.1720756885012;
        Thu, 11 Jul 2024 21:01:25 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a26d72sm57913355ad.63.2024.07.11.21.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 21:01:24 -0700 (PDT)
Date: Fri, 12 Jul 2024 04:01:20 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] android: binder: print error message on failure of
 creating proc file
Message-ID: <ZpCqkPIOCsnmf5lF@google.com>
References: <20240712032140.4012667-1-lsahn@wewakecorp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712032140.4012667-1-lsahn@wewakecorp.com>

On Fri, Jul 12, 2024 at 12:21:40PM +0900, Leesoo Ahn wrote:
> It better prints out an error message to give more information if
> calling debugfs_create_file() is failure and the return value has an
> error code.
> 
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> ---

What are you trying to fix? My understanding is that users of the
debugfs API can safely ignore any errors and move on. IMO it doesn't
make sense to add this without a real reason.

--
Carlos Llamas

