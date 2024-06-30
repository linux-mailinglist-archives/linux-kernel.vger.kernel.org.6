Return-Path: <linux-kernel+bounces-235337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B703491D418
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 23:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E298B20E7C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6164F47A66;
	Sun, 30 Jun 2024 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXQu3jyC"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD082C182
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781398; cv=none; b=ZMr0O0NC4HMAohTlVoKyXrpIrsfU564xnizhWcP+HXvaoqM1+pu31n90op7NhU8XjQPpO9KRSMRHujHwAePlWCRhW8wDNIIwoT4TIvkjdflD8k2RFzh4iIuIXdXQ8bjKwIpe2I3hJ/SCYW7cv08BhY9nN++Abzl6Rey1QIU2R+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781398; c=relaxed/simple;
	bh=bmGReT06QR8U5+08gkLzRj5wNHELS7aXIy+Kh/dGdHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMhZsxRJwtAeMoBW4Bwe5PWRACDiPsWbPsZMQin8PMhkSL48y6D9hWpMYlEkxuOf0GMaUDlnhguRrZBlJ2Axva3kagfpUaTCiPcmJl2nPVaU1C6142DnW0ybEhb0Dvd4ufwEcfZ8qT8TnqESFrgTBJCngUOoXmjtSEW57rgMzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXQu3jyC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3629c517da9so1991364f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719781395; x=1720386195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn8zoOCppkz1MVyNN7FtalyPUaz4TtRfMJv4RFmaufk=;
        b=aXQu3jyCOJoDoGCVtZQRYGU9zb91L26Q+ggPi+yt6R9XCrkbr70PZRiEHfkfCc5VR7
         6IZzin4+ml8PMilsWjpKG+MkUQNz1sM1w/FeOS/SLc2+WeB3PVQXBWBi622UFp8FD8Ld
         Sr7ycGAP1YeAlzMjeNWpJyLvoSIaAtlONPPAyVh39aQhYz9oB29RDk6A8rXaqKYHFcsc
         qJ8nK892Bhc/YaaAuwtgQdf753gTh+rM4iKQUiw5QOguD/3PzkEQnFt+UFJc/TQgVK7Q
         zahtbcSxCc8g4OcKiWzuIUO6Y47mPA3AZoQOOjIAK084tBSSkeD8D6+ikgEI7KBZCDI1
         D2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719781395; x=1720386195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn8zoOCppkz1MVyNN7FtalyPUaz4TtRfMJv4RFmaufk=;
        b=ImqfLJfNi1KyH8fhJjgsZGTnpd2aYN85kkFBtNiTkt4eXsc/R3boydvYfTRwSa9/dx
         J6D1+nIXhKP0xkAA8vldmCUnPNMshls5hINrfWRlZoDz1IHqsFx2LfmYCQS0P1l/XVRU
         KwDsG39jvBDQEczck9YpfhInQFB+XBQBbFfISq2Jyw23l/YZL9DFPy5O1gg4Y9lWHnOK
         7+jEmi1hL8NfN85R7WFcbFAeJUKuHar/Rqri9brw1mN+BRQS+4tylfdYwsWXbdnxCwIZ
         lwqfbeex7kk3xy2jgcWkF8LbO1I/zh7S22YaCd8IleXCNTl+UlCbn8NyuPnjiQ6CRDyk
         Jinw==
X-Forwarded-Encrypted: i=1; AJvYcCXrimByq8Yanpel1b1ARvApiP9UFPPtQcLRVptROEsI99v5X1vBkdcMrxghqfG7FuUbJNWMaj6pVHSiNpzuDt7tNXDq/j8DKMDYoSOV
X-Gm-Message-State: AOJu0YxNF11VhIpXIruu3kKjibEA3DdNMKrQA2jNJnqft0LccwS0iZlY
	bOs0MpSRcXn/g9c5L20ljwA/DrC5mQZkT+dTbcLasyDkdEnMHEmj
X-Google-Smtp-Source: AGHT+IHBNYUuSXWgDj1lBivLXolqrQuiwI0qYY8jsNAsYZLjds4YfZ5UOxJLygjSbJaMlykGQFj2fw==
X-Received: by 2002:adf:f248:0:b0:367:1696:9cf4 with SMTP id ffacd0b85a97d-3677572fa8fmr3175494f8f.57.1719781395380;
        Sun, 30 Jun 2024 14:03:15 -0700 (PDT)
Received: from debian ([67.208.53.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f99sm126118125e9.41.2024.06.30.14.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 14:03:14 -0700 (PDT)
Date: Sun, 30 Jun 2024 22:03:13 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: linux@treblig.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org
Subject: Re: [PATCH 3/3] parport: Remove parport_driver.devmodel
Message-ID: <ZoHIEUCaYkOFnmyt@debian>
References: <20240502154823.67235-1-linux@treblig.org>
 <20240502154823.67235-4-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502154823.67235-4-linux@treblig.org>

On Thu, May 02, 2024 at 04:48:23PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'devmodel' hasn't actually been used since:
>   'commit 3275158fa52a ("parport: remove use of devmodel")'
> and everyone now has it set to true and has been fixed up; remove
> the flag.
> 
> (There are still comments all over about it)
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

-- 
Regards
Sudip

