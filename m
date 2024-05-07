Return-Path: <linux-kernel+bounces-171076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7238BDF88
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1951C21E11
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508E214EC57;
	Tue,  7 May 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="S/Qq5gzu"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37714E2DA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077081; cv=none; b=pBy5P4gL3YWVLNdL0Eat5Ih4DR8sPyctNX+rPwxZ8Wl9aovN/VMkKgKYgjS5xMgMwvtwLxMUYHd59TJyC0K5ae9uaRrtEVfQIDH1qPgKqiTpH70X0vmMP7xvtm1CZd1fY6Cqv1DoNllfiIkezD+3fRvs9RmtiUMnfIvQf6NBKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077081; c=relaxed/simple;
	bh=dnCLNFqvQAKBlSVAP7aFTgdYYOKaC4MBtRCs2QJDt2U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=toBssSz+Sjukk4gIboPR4QuUSdCFUCCr6I1cA/qeceFDd3DiZGo0zVJbTyWz0RSxh5oJckF55CVN37z0Wm21JRbb4hvtm8jxS7cfsuNZ7qMAXoZsZKIUE/aEacU9GN46J+SN9gZZ37/rFFH7RK8PUVG0jRS5BlZdNlLb5TTk/9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=S/Qq5gzu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a599af16934so720058366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715077078; x=1715681878; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac5rOAJKSZYYZ0IEteEWbW9YdJJoGTwzrFFHY2kYg9Q=;
        b=S/Qq5gzuKseZ7YCWKBf60ssxFOhGzkjH+zy5ZeYkFUiwmwPo+BabomtxTypUAInS0H
         sVfc5KiMrP0ywt0Te4trO8vTsS/IP3jGUzYVrKaKInXxYz45Oa9P2QW8VQ2JGPVt97NK
         2DBoJMKbOXOf8D2+CaiAaHd+YjojCBYo3AX/5K/cAV0hi6kCM/Jms8h9TmTKV5UMv+hd
         4Lq/GPQ/IG2Z1Y6YS/GD8OMAfhNyKbJR5OzfmBva2Gv4FeNdQRgoH/nmYbYQzJB6tHOH
         A8xtVaemSohmeJgbR0Hh7jK3JPhT7EPK1lkrTVUnXRPPlui6EKhlHKn1FBEPcio6RbmB
         A5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715077078; x=1715681878;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac5rOAJKSZYYZ0IEteEWbW9YdJJoGTwzrFFHY2kYg9Q=;
        b=rLF29pBXT8QY4mg6c39fwi6EjcLfV/mfvE+SW5/NBOH/ZqMQWwz2JM3GX/V9yub9fv
         AWFPKkeq+pNVfwu/JZ1t9IEh02q5X9kXeCjd6JbaeZ+bIXiYxDWZpLRQQ1t6v+HQZY8y
         JV5XeRtIJh7n3trDwM//G8cKsB8Za3N2eNbzc1jzHvHWnlLatnLVJquxdn0rOsJdPVYr
         DxhAZAMS6ZS1z9i11TfqFOsYIBua8NWSBFyLHoP35xmq/EjYOS0j4TSG2tDeLbrhRaaL
         0qkgX0CXYPat3wbi8oIkh5EP2wQs8yHhMGCiCB6C0DehZn9koSDcdYW/dsFHBuXvpL2x
         u3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWPL2ohdZNhiNOCIXxPxt2vNMzufDJ0WvvyKio7+1STrB2Xwh4W+vWUU3G3tScfQY8gWuXhYZwLYnf/xWXTg567ryQi32SDn63SNgXG
X-Gm-Message-State: AOJu0Ywbw70u3fUDp0WTreRXxM4/9lml1WkakTgBG7ydMGznnuGVNqCN
	fPX+b9wRiDIoVrRqoNKOy/wjXw6cxlrvHWvH/Bbh/2r+E0jMoinxJ6Jd+YVWmlY=
X-Google-Smtp-Source: AGHT+IHidoSypSQADr6hPkvXXj9CkAePoe6AE430g+iLHQAqPdhRx8cN0msxxdBv0xp6B/nlsbgYlg==
X-Received: by 2002:a17:907:7883:b0:a59:9e02:68fc with SMTP id ku3-20020a170907788300b00a599e0268fcmr7160173ejc.44.1715077078321;
        Tue, 07 May 2024 03:17:58 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:5c28:520f:55e:647b])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906a01000b00a59c3cec28csm2976114ejy.10.2024.05.07.03.17.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2024 03:17:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] bug: Improve comment
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240412135406.155947-2-thorsten.blum@toblux.com>
Date: Tue, 7 May 2024 12:17:46 +0200
Cc: linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3E99B315-844D-4B5D-BD5B-CFC18EFE304D@toblux.com>
References: <20240412135406.155947-2-thorsten.blum@toblux.com>
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 12. Apr 2024, at 15:54, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> 
> Add parentheses to WARN_ON_ONCE() for consistency.

Hi Arnd,

could you add this trivial patch to your tree?

Thanks,
Thorsten

