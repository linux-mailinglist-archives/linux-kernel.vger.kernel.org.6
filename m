Return-Path: <linux-kernel+bounces-269422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5779432B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AA02861B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453817579;
	Wed, 31 Jul 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QuqzyIQ3"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1D1CAAC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438472; cv=none; b=Hogdv4kwY5AAvwND9z+nUwyDKRXPctNzmBEbahKaO+4TQNUaLOJDNz3rQj4dOLjhYjJS4nqark8OkJWADp/c+jFGlPmntKP1tEsR0knGKVHXx/7P8dshQHWn4G01jNWi3d8W3DdrinNhlIEV6Rau61XobSDzgPyKKa2wmq1mNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438472; c=relaxed/simple;
	bh=iP1NxH127btnW50gnvB5w9L+XsSvvMhs2i7Azuvbfpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5Aewvx4QU5HxWJzAWaZ0I9HHhCcbG8Ggu1CkeJeIv+kc886nofNb3jRQ6PIQJj32Risq6ao0EHUTVC+hOWeBzH38mGmCveX+H/JW56wtzd9Gt1bn0O6Vgq5H1J03NWRU1cs0NRYNP0oZgXn5Pjj+FaDnSzSDi2PK3S/6P0VqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QuqzyIQ3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso6366629a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722438468; x=1723043268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2eomkWSEfqxmeXJ2mXgbcKL+Gc+ZPskWjvUawS3yh8=;
        b=QuqzyIQ3JCAJ8bAlfw/p+tjsxAXs2D7vWSIW0rSpbngHY6ZfYLZgazKETiwm8mK139
         /kXiJngGJhTw/Q/gKDrwG9uW3AJdDIQ7WhqUAjUcctHiK+XsAdQOGsvUcDfLr33rIv4/
         jtKd/27s5cqLxxqTsZvGRM8w8hek/BynKisxts6yVu/Os6gDeP7WxO7T4ZGpiRXXSa2/
         pwGea7kPpANvRcFnw8kuT0K0Mkobd1ZfrJRYR1jtSQ59sL5F+V66LYnDAoDcJmv2CUn/
         KAQJovRemozANvd1Hkdu9KxWHjCY9vl/DHSqcu8EdF0LPvc3it8g2B2d6yVp82G/nZJw
         VPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438468; x=1723043268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2eomkWSEfqxmeXJ2mXgbcKL+Gc+ZPskWjvUawS3yh8=;
        b=pJHGaK+H8qWkZX7Y3TMWQFi+9alwU/UzjGOenDSTVolYdZfyN3sdYKpahouEPw2rl8
         ttsV2/+G2qHGNBN1yEzQAg6Sl7+gxWhJbVUanBVWUnCnLTTjxg/o5K73iJsfZfwwaxDv
         JXgDsUSoFIE5rJUpgKmRHDjbmuOsE5YglXZW3fwYVsGlmF8PBTaJyo6JEGaHeuBjzXOm
         /FvCUcFBRIlxAVmPD5GGnehTHUx83KxhSctibNQWn0Rq5oUaqP/7UHNKSj76lF29D4F1
         1O/LETGqucw4uDoHxyrft2wDlKJ0Ci0oZ/iHgkTeFcWfZ5wxxTtp51nx2XSq0xG41UWL
         S6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW4KDVviKvpgyl2RcUF4k9JSrjQOWuaJBlrFPpPp3omQkVN5vc4dFbrrlgN6/Es0CCZF2BmIPMuf5SGeTI3lzMgrlYCoPJ09Cir4BbE
X-Gm-Message-State: AOJu0Yxfb66JEyH0FAqoDwFmxSjgc7ej+dVlBwTVtCc4kHqM0fC1ZY3U
	ys0bwySdNJhjpPDXB2zUwNu7c1H9SZKI2d9GXYGMocGJJc0RKh17dKoUu7etRyc=
X-Google-Smtp-Source: AGHT+IEwnvtwhfLLeLzn1bYGodP4q9ALIGyImHhEVNjIC7E01AiPuIt2RA3tGW0kOfv7VquTNsoL1A==
X-Received: by 2002:a50:9e4c:0:b0:5b1:433:579b with SMTP id 4fb4d7f45d1cf-5b104335cb3mr7362752a12.37.1722438467640;
        Wed, 31 Jul 2024 08:07:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590d1esm8839397a12.27.2024.07.31.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:07:47 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:07:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v3 15/19] proc: Add nbcon support for
 /proc/consoles
Message-ID: <ZqpTQUSTmuBQbOrJ@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-16-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-16-john.ogness@linutronix.de>

On Mon 2024-07-22 19:25:35, John Ogness wrote:
> Update /proc/consoles output to show 'W' if an nbcon console is
> registered. Since the write_thread() callback is mandatory, it
> enough just to check if it is an nbcon console.
> 
> Also update /proc/consoles output to show 'N' if it is an
> nbcon console.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

