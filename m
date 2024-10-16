Return-Path: <linux-kernel+bounces-368196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423B59A0C73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A049FB287E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE992071F8;
	Wed, 16 Oct 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/6fsmOs"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491B1422DD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088405; cv=none; b=VHjOCtg5qpvv37mR/4Mc2UVEToW/OdMpZ0RknsGganjNi7Kknjz9bA0TYFykg9/K4SbO6Ta37NWnAhoLpIPp9nZNdPGa8LyzV+l1lpLjQmZw+QVcDjFv65qr9Ug54fYFaLF5t4lRx2PMEsLSAWA1z/pjZJaolq8xQ0VFVzaiBdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088405; c=relaxed/simple;
	bh=pJUkxQtwyw746nk67DanPGVIfzvUtiNSIx6NJeAjoGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=on9ktNDBpko45gOAFpBroQaAMORgNrMMrHaMewO0TNP1+9hnpd3+zPfxuLke2f83RuM+GFDyDTdc1YwyopnnMp+foREEMAybSYsjzI5ZFqfAnLmuF/fyLQ5XqtuDNVbf2ef2OL0pzspTc0zcvcSKb/5YK2xqF5reZgAOsvBVbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/6fsmOs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so6939628a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729088402; x=1729693202; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6YX0eX++W7tAw6O3U3cWC8A1iR7EUNPF7MLoOd5k00=;
        b=h/6fsmOsVKa/rTFjLs7/ohro8Xj9oItztNAao/PdoEYl/fiCeqXyY5E/dK7yN0qB6m
         zChMX5JqU2zzzK4cXTb5ufUMwI58YS4keLW9ZXbBBnrJCUMTMguLYHvRktSde3LHXIzZ
         m+klZI2UX+4E4BudjwL6NhGVgu++Z5NI4Jqs5n9Mlg004gt5cbPs6wBVi6OX4de1c3Kb
         q6tPM8oYFPlTSL77V0R0uuW3MVk5umEdL/5lkaynvO/RnOkEQjCsO9+kSX7hOiEfiir2
         OR3yBbnhCRPjXBwAk9qGLPq3TymOebO8Cpb6JzU87TQAF0PrkeQcD2nhLVoK2GSzLcQQ
         POnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088402; x=1729693202;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6YX0eX++W7tAw6O3U3cWC8A1iR7EUNPF7MLoOd5k00=;
        b=vL0NGJNxxI/LdiSeaZwiCj+9NhItIa6MdLmeNNyFh5rZWIaYYjPR8HYg+FBQECpwWJ
         /OAPotxt71kUC3zngeATY4gZHg+s6zlAtbEOQlfv5JfiUiK6XAtvTmrzaNEbBSATlDFp
         vbYBvMVcg/dnzrW7HWOjd2BNEp4WYfsKc4PDyqRxapHbyIDMjD85Qjct/2MkOkKKBhSY
         bPpZnPXEeq6iMYuHKkQ4suwpd9mj4Ww9ZDsDxGZ//JVrBDug5zdtH8lNC6bmqjLS+xld
         /bKF1TfA4oj8hvHJlSOReBZMMT17oBHNuV5nVgRvjOVbXgTIiTJ8COPfrup0aO5KZDIR
         g6fw==
X-Forwarded-Encrypted: i=1; AJvYcCXcGw/zkd9vO8caUFwwsW1HsFFzmCq4iix0ua4xSQI7uuJzWuRqz8PjFeAkiIdIy26r1T9rOyTKrxjOvIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jWXI6y6/FIRDu05pQLLpU9g2hZaYYTaZhGRyn7ZTtXfb932u
	dD8sy4ShXfkx7ptqn6olfIp1j4xGix8tR8NZ5gJmfXM4xyxEnNnB0DjHHvpriH0=
X-Google-Smtp-Source: AGHT+IHZn1ughsOxXkjsi52tYdi0Vt+QgnG0sILlX8vmnAbEOr3JjvX4QEzTCq1ABBvJX69sd1x70g==
X-Received: by 2002:a05:6402:5c9:b0:5c9:58a0:240a with SMTP id 4fb4d7f45d1cf-5c9950b9252mr3065086a12.14.1729088401552;
        Wed, 16 Oct 2024 07:20:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d6297sm1769537a12.15.2024.10.16.07.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:20:00 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:19:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: other staging/gpib bugs completed
Message-ID: <912561b9-e446-42e8-8922-9e8952355c79@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Keep up the good work, Everest.  Here are some other bugs you could fix if you
want.

drivers/staging/gpib/agilent_82357a/agilent_82357a.c:1381 agilent_82357a_attach() warn: inconsistent returns '&agilent_82357a_hotplug_lock'.
drivers/staging/gpib/common/gpib_os.c:889 board_type_ioctl() warn: maybe return -EFAULT instead of the bytes remaining?
drivers/staging/gpib/common/iblib.c:242 ibonline() warn: assigning IS_ERR()
drivers/staging/gpib/common/iblib.c:505 ibsad() warn: AAA no lower bound on 'addr' rl='s32min-30'
drivers/staging/gpib/eastwood/fluke_gpib.c:592 fluke_dma_read() error: NULL dereference inside function 'dma_unmap_single_attrs((0), bus_address, length, 2, 0)()'. '0' '(0)' 17 9
drivers/staging/gpib/eastwood/fluke_gpib.c:592 fluke_dma_read() error: NULL dereference inside function (pos=17)
drivers/staging/gpib/eastwood/fluke_gpib.c:949 fluke_init() warn: was hexadecimal intended '10'
(perhaps intentional?  Just leave it if so.)
drivers/staging/gpib/ni_usb/ni_usb_gpib.c:837 ni_usb_write() warn: inconsistent returns '&ni_priv->addressed_transfer_lock'.
drivers/staging/gpib/ni_usb/ni_usb_gpib.c:1103 ni_usb_request_system_control() error: uninitialized symbol 'ibsta'.
(this last bug is tricky to spot.)

regards,
dan carpenter



