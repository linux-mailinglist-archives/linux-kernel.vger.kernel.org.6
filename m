Return-Path: <linux-kernel+bounces-176186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952008C2B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AADB286BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190D813B586;
	Fri, 10 May 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c9yA3GnN"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97110965
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374847; cv=none; b=qiXDOymcqzfRqfiKwL2WaymRA+MVb6n/JjPfCxmFRirVbVi0cW2iJRZoAYi7hTWoYKYDFR8QIU7WCUEHjJ107U+q2py08XNHqcg9/s3WPGxr+4ywFKi3YUqop6smVr9QnPYhrSYNaBp4nGvHkxXBZUzRhjcaU9pVhm6440WtxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374847; c=relaxed/simple;
	bh=+v2CyGWre7FViv2q+gWskzmC08UpI0br+uxEzFMUgiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnXkukmLnkKkVz1YZ0T3afPxrIO3x7eosVxZRvAMN9fuswg5BMOd0t5Brb8jFeS9LP4wIJ4lYMjnwA83xy+gyRy2uXtEePHklGcG4V4z4OS5tvBsPvAF8lTk3ceSF31OJpg8sBGKXZttMCUg4BC6TNtORX1/BYm+kqzU+mae8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c9yA3GnN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59b49162aeso601746666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715374844; x=1715979644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DUX1DFhjN4Cse0eC9UIMDH8SiM6U9i/F0JxyDME3sQ=;
        b=c9yA3GnNdYquBNcglY0x7x2/A3ixBhvRPQU8Y6hxc6Oe8Qys7iO2/WEcshggttusuh
         ND4f6utC67soJoospycQAUv1mitxuZdlHGBtdaWGjT9DrEH1tL9TRYKfSnGQ3B2mrwJy
         PBcmphnjSgDmkeeTIH2bw79s6tOjYzUc9A0xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715374844; x=1715979644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DUX1DFhjN4Cse0eC9UIMDH8SiM6U9i/F0JxyDME3sQ=;
        b=OwKMdWA51+vt3lRQMZ8iY3BVDBF1v4pM18sVsfojx/senfn7Muz+EraHR7XzJDeooj
         cVAWAgqJgzFG66JmeXst1myFNkhfd9bxi+ocS06DAT8RIf3KGy1wzpsZmoMxjjxj8C9F
         /mQFkTLscqmsGpMYofNc9ZY8N6A3Te7vfxY7FZ7qXlGjyCsB+13i1v1DskhjuKLqqWKS
         p1MD8hwvVdBCKMy97EEHmb/8rEeP6gh4PEn1hhXdJhoZWz2PbwWF/WVXuQ/weW/Yl4L1
         DhECaTxRKLK0RIIzCvcn1Lhpibi2ZVSefuBBDftDSKA0SFHU8VlbFVQ2JNs6HvXTxjI6
         mBvw==
X-Forwarded-Encrypted: i=1; AJvYcCU7DlJzFzBcSI3AmKLTCK5+nioVLIKKciHwOgTHlj2DIpfS7IxP1tb/L3tAXuROHJRWYtWPHPAzkqx0S8LKbWf3vmH+DMXb5Q/dh9uB
X-Gm-Message-State: AOJu0YxLGGQmw0UgH2VwUgcZro7+q61XRJJt03df3MPFfcYvtBQ9Ky9B
	kSwJh2Q5XGD7rSWGiFpaMmUleAoM7ig7U9pyhjMDAU9C3U59YOoI0hHe0YKDDup5VvIJgn3rcEd
	ro4A=
X-Google-Smtp-Source: AGHT+IEqBpGhoOnKp3yLEyJvVbAWjje0OiIWH++KNFwApw9cX3uj/+4ZIzLOxIlHEllDk1WCDPuaSg==
X-Received: by 2002:a50:cc93:0:b0:568:9cfe:1974 with SMTP id 4fb4d7f45d1cf-5734d5c2519mr2489275a12.18.1715374843692;
        Fri, 10 May 2024 14:00:43 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb331sm2221967a12.67.2024.05.10.14.00.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:00:42 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59b49162aeso601739766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:00:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfFu8FjF67+MnEsQCPUXPAoB0u5BtnD5s9gRzAfNZWjlYHTrq3uVMEp8PBb0UDhGTxFtrzh/hmJJkLBdoUf5AsbTnSILwWeKMDPLi5
X-Received: by 2002:a17:906:9982:b0:a59:bacc:b086 with SMTP id
 a640c23a62f3a-a5a2d641841mr239515866b.50.1715374842012; Fri, 10 May 2024
 14:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510131743.cf12a22295edd6ae4c175d5b@linux-foundation.org>
In-Reply-To: <20240510131743.cf12a22295edd6ae4c175d5b@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 May 2024 14:00:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeV5w3=K_r5+ypeB6_JWKiN7CuiReTn+6BMTyXvXZ2pw@mail.gmail.com>
Message-ID: <CAHk-=wjeV5w3=K_r5+ypeB6_JWKiN7CuiReTn+6BMTyXvXZ2pw@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.10
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 May 2024 at 13:17, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> 18 hotfixes, 7 of which are cc:stable.

I assume the subject line is wrong, and you meant 6.9.

              Linus

