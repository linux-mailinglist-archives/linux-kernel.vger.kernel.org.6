Return-Path: <linux-kernel+bounces-518867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7EA3958B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD117155E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26B22CBE4;
	Tue, 18 Feb 2025 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="biSovEpA"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173BF22B8A5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867761; cv=none; b=dsZT8GzhZ5IE+2sfjDbfA9/N4xona/ZiWcNF4GBxs8Wg0XwEzTjjU+mYMfiRidEis8yNebs4lnt+HUcQT3YRUarSBxd2YaPRXQy4rbuDt6qZASWNyr5YCVAPu7YLFSuyRZHLnfVwfyxOCNnAm/SxVO/zREa6g9bzYEFrtAOhlMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867761; c=relaxed/simple;
	bh=feF1eHyyT0zWjy4z/Md8u1+8+0ZLHRFpAShbWTlr/Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FELcwK7LGzXm671EB9gOetofBQizlX736qkVjjkjtQYEgU7q1+UlYxmHov1FWaG0I2iab1kNZhNCE5LTn5w5LXcYcPclOXtezNmVenvIJiUvkaljip/WZTttHusx+MP80GN1F04iIm73G72/LKqNwSkdqkWmoUTKWYzS5ek9P/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=biSovEpA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4399509058dso493735e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739867757; x=1740472557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MSJ23b7dcp2nXbCFtNTYLtGlvCk+YzKblQR08ITEHhc=;
        b=biSovEpAlE38/v4+KDQyJgZSbwF/zPlf7WvgG0duyMN04oAZ1udX/rkeLmf0f2KCes
         XrIqKcLyBtVy4U69nNVrLi+R3ED3wNcTTItEWUA95EOZQggaqiiwnHp5FAhAdw+d7WM6
         6YH3sZqKyFoDwtoor1DIE3P0tEy7dnIWBIE1D/porQxnkqyikFrPxAQD9R6z3RVCO2xV
         ncQ4kcuE/DlHyoRwoj1I0DsngPlfYWFv2DvjHifmtuoZnjewTO9Dp7B30PWzu8fadltL
         BsiL9577C6AYT4GGiBC1yyEO6fZsw4trvTKikHqS5wGApwmjxTWYFAVkqLHQGRZoKa34
         rJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867757; x=1740472557;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSJ23b7dcp2nXbCFtNTYLtGlvCk+YzKblQR08ITEHhc=;
        b=fxeS7HbAMYF+gH+h649BI297w4oOwBf2Li99zxDXhrM1eKEP+LGjHyX3jPGdVDo7f5
         l6KOPx6JjKMgorhDAU3Q4MtYeTfxn3gJgSEh0NtcCDyRUKOWR1sqCUlrBY99YyFhSzDD
         e3qkSTBk1fuRqmLSM0K7Zl1mBPrbkYXcjWUkY1O77y0+jYQ7/X95QcK4rRW9+DuzQT+a
         5c3ehosAnQ5lHiRuoQeHMX7yOPWI44+Qw8MMGW6i+lxmdHIC+HMqw5GFvFg2Jha6XGnI
         HNHTficYPNYtrc/09vlr59CDxtjM2iIMrfdd+Xovyb7xGuHFkcU1k7noPnalpyXjSSoQ
         XJlw==
X-Forwarded-Encrypted: i=1; AJvYcCUQEXpIrJj/mQFtXcp4ruyZIqg9D6Mwb6QykI2UFQvGjrR4VG9CUGnxamd46+5/ic/wJZZB7K3cashmaFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxysdUkaD3VfUE/BTa7z2OhtpNFzOcxvm3GX1z1cuNmE7eL/PEI
	czkdyOFxa57KVdpylQTul11imKfWw4TUJzC7diB68Zf+gOhF85ym1MII8w0a7go=
X-Gm-Gg: ASbGncvuzrdITSL7F4Dvj2vepDk6gRW5ljAEbzFAqbCDwG2Uh1jHwTexXMzabSavY61
	XA8XJ0y7wfCiVtALxbSGz6kkWN7EQ/+sYEN1QvXSmz6vlBr+L3cBEoQEl3Tk/DFKCF3K3AmGfxy
	ISs0jZm+QwPYlLo1vnRzAUhqgzeetzkxESDue7wxp1M3cIemWwJuOUNUWSaEf3hMh2omUJeUb1l
	+OgA4qfvlsB7p9DV6ZIkoGxXwNJlQE0/T9at6w2Aza6UDBtGIsuV4M9yaUzKlbTBU77EXJkG0Fi
	7c/WKanGUc8LP8GaA3Oo50p+JS6lNWhvEf+7ig1SPG2yBSQjtYr9k4V0VDTAmh+ZR5f+
X-Google-Smtp-Source: AGHT+IG92hjCJWGEFWUkF1TNBt8VJRHE77BbFuIFujokh0dlUjpL0uxRKa49heL6SedL+6HcLajH0w==
X-Received: by 2002:a05:600c:2d04:b0:439:84d3:f7fd with SMTP id 5b1f17b1804b1-43984d3fb0bmr21918935e9.4.1739867757357;
        Tue, 18 Feb 2025 00:35:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:8e5f:76fd:491b:501e? ([2a01:e0a:b41:c160:8e5f:76fd:491b:501e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439858ec5fasm48100965e9.29.2025.02.18.00.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:35:56 -0800 (PST)
Message-ID: <715a9dd2-4309-436d-bdfc-716932ccb95c@6wind.com>
Date: Tue, 18 Feb 2025 09:35:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] net: Remove redundant variable declaration in
 __dev_change_flags()
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
References: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250217-old_flags-v2-1-4cda3b43a35f@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/02/2025 à 16:48, Breno Leitao a écrit :
> The old_flags variable is declared twice in __dev_change_flags(),
> causing a shadow variable warning. This patch fixes the issue by
> removing the redundant declaration, reusing the existing old_flags
> variable instead.
> 
> 	net/core/dev.c:9225:16: warning: declaration shadows a local variable [-Wshadow]
> 	9225 |                 unsigned int old_flags = dev->flags;
> 	|                              ^
> 	net/core/dev.c:9185:15: note: previous declaration is here
> 	9185 |         unsigned int old_flags = dev->flags;
> 	|                      ^
> 	1 warning generated.
> 
> Remove the redundant inner declaration and reuse the existing old_flags
> variable since its value is not needed outside the if block, and it is
> safe to reuse the variable. This eliminates the warning while
> maintaining the same functionality.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

