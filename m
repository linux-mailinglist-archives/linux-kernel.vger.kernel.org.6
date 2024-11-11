Return-Path: <linux-kernel+bounces-404607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF49C45C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1677BB231A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986AB1AAE2C;
	Mon, 11 Nov 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKSo/OMr"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718171A76B2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731352065; cv=none; b=GuBUTAaBFzVMD7cfZogXTqf2bfmp9a6Uu0075UYc5eSkEk68FrFHQwF2Q3Xu7RdXCFXQRN4VGwiEVvf5B7gNPLeDzINzNRwL5mcQzuBtYWDRPIsBjvZ4nfXVeiDpVY9vJ/9RqvN2WspU/UI1qUEJqw0k/lkbOiACvo9zY83cTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731352065; c=relaxed/simple;
	bh=TbPb0hrPhWlOrkG1Avnn5wk4uaIKLVoz0bFSvdF/M0Y=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sCxJ4IQ5oLN0P+M8gsgREgIVMO7wZOul7QW/s2XIyK2SadjXahCoGj7qllpmUYIBiWPv01UqcMLJQSjDmpp36Q62+tKhAJHIepjbGnyhMy20lAohtEk+JPb/4gvbxbdHi7T9zevQ9Yq3FLcOUWoU41Vrf16fH+lxdcVOztwxkZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKSo/OMr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so3413316a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731352062; x=1731956862; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbPb0hrPhWlOrkG1Avnn5wk4uaIKLVoz0bFSvdF/M0Y=;
        b=OKSo/OMrQuJdAxjd0SQtl/DPaiyn2FTv/1S+OmFN/YfEViKixCGL4TToTJLEdkAu25
         FtpJhgwwpzCjPXkab/Eh9DphZcPODboTqKoVc/ejmyFiouKD1f++TYtHJoMww9nKrQjp
         Chu3O8E5KLCq2QKXpGTCUI74TwLbYPoBKDBalb8k1bweQ53SL6oPypmtotaflOKcYhJ2
         LDhi40OBkNdUMApSjM+UZRTI2AZFD6oAIOQpl4NBmnVH8RM9xvBM7TAGFcwUIaBr2cTS
         6OHwvoy4JyN5BJS2M1YT2tD9OVrWwEFk+L0tDxp1Yx6uOLCkVbEjO+m6jcHqdiZHE1Cf
         oyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731352062; x=1731956862;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbPb0hrPhWlOrkG1Avnn5wk4uaIKLVoz0bFSvdF/M0Y=;
        b=a7yR7tvSDyrCiMq4+xx402SVE55QR4ZIwSanelur6p67ag2gEvaLEiEq7ySfoijfjB
         QCWkjulGXPpWC8ocX9/7YFKaiDWNPKBkEhJaSaYjhylo8zkugDs8J4w9mqfy3VR0tEX7
         6/S3ShhlZggvXhZWwttLJezBhDnrLK2RBa2b/qbO0mWYRBzr3V9M5Rbob//RuFk5/28f
         oMXxYjMBdxFORJ1J/qPhK5DpDb8pJE0lUo/26wvuqzYw+yfHOoNxhMpup+nB7cqeKG4r
         3+voFreaxEv6gG30mzWqOuaaJwWEZEbyUXLabPzGHAibneNRWThqVNfd8r2qN6ooK7On
         g9qw==
X-Gm-Message-State: AOJu0YwI8lQVcWKhRYRQdiJQmlW9v/SYtix1LgFgYVouh8Boe+Il/lKt
	eygItkNqXHu9IH07XM6OUIv32uM25D2LRhE6BGyEDYnJUM/uefiW2XjMig==
X-Google-Smtp-Source: AGHT+IFcNMpjLe0/KswDPBVvmEa3WvRidDhp2BxNFByLW9sHnZ5JPmUqoHxrzUfASkA2+BjcBVB0dg==
X-Received: by 2002:a17:90b:2e07:b0:2e2:d112:3b5c with SMTP id 98e67ed59e1d1-2e9b1796555mr17775736a91.37.1731352062256;
        Mon, 11 Nov 2024 11:07:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fe7125sm9019431a91.43.2024.11.11.11.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 11:07:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <67d549d0-64c6-4d62-add6-0958ef24910f@roeck-us.net>
Date: Mon, 11 Nov 2024 11:07:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: regmap I3C support
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

in general, regmap support for a specific interface type requires
a matching configuration option such as REGMAP_I2C or REGMAP_I3C.

For most interface types that works just fine. However, I3C is
kind of an exception since the same hardware and driver typically
supports both I2C and I3C.

The problem can be addressed by implementing three drivers - an I2C driver,
an I3C driver, and a common driver. This is done in the st_lsm6dsx IIO driver.

For simpler I2C / I3C devices, there is module_i3c_i2c_driver() which is
supposed to register both the I2C and the I3C drivers and handle the situation
where I3C is not enabled.

That works fine unless the driver uses regmap, but I3C and with it REGMAP_I3C
is not enabled. There is no dummy function for devm_regmap_init_i3c(), so
a probe function for an I2C/I3C driver utilizing regmap can not be built
unless REGMAP_I3C and with it I3C is enabled. Ultimately that means that
I2C/I3C drivers using regmap can not use module_i3c_i2c_driver() to register
the driver.

Am I missing something ? Otherwise, would it be possible to consider
a dummy devm_regmap_init_i3c() function if REGMAP_I3C=n ?

Thanks,
Guenter

