Return-Path: <linux-kernel+bounces-535086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967AA46EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB95D1887919
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E3A25D206;
	Wed, 26 Feb 2025 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEP3xGZa"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9925D1FB;
	Wed, 26 Feb 2025 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609502; cv=none; b=dAIfvCFMqtCo9YU5SeeBJqhgfalOfl/UcAoOBXBHMpvtfmSc2/U2juFT5SLw9KvIojAxTyLQsy+Gz3f+P2fcfOWFzsnTLhn5zIvWDEy553XBaTIfKA3o91zQCuAatXJ43EHMIO4fcBGsP2PtuwtTI4EJsdX8zRRuokbkkoY4g20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609502; c=relaxed/simple;
	bh=Jqg6xgss2TwTJnwYTz6WVElRsaDmvCoRkq61/S/VaTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxunCH50qJCArgxn1o+ImPu/9QYNaSQmahieppvot4axvd1WuZ+EPjYA4LSp68TkroPdXpAHy6EFQ7CcN4DhRN6wQl7alLUstCnW7JxJmBwj4WjvIyqF0/hjPk9eGzzCD/7y5pg6YIsWrMGFw+a+o0XbvUZ5vAGzJQ4ircj6IpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEP3xGZa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab78e6edb99so37042966b.2;
        Wed, 26 Feb 2025 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740609499; x=1741214299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqg6xgss2TwTJnwYTz6WVElRsaDmvCoRkq61/S/VaTA=;
        b=gEP3xGZaeyBrxX/hAyDZsRp45gwXbsYRGmauAqH3XOF7u9Y0j8p9ssetYpxxZQIFT7
         JlkIdvCT2hYUxEP2dmaghzR2wTzIE1LOFHi8nDRnyNSryQstwszM12BQcPKOQNI826iU
         TaUqeHHT8VQVsXQV67UnaNYJgjxDqePqndkMzQfl2bzcQeBwIebwmdgDKqDUOT2TNRhh
         r4HIweE6SztITBWNNaezTRnBH8wBIC3QA5LPIlEN3ZbCvUOzSO1r01c3MOjSfPSc4hQS
         LSg9o6X/w28UTrFlKfaVVR/X4vKTUzOExppi2GFKrS6VVvQb2T3qWeJH2yJQN4nUOuKJ
         781w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740609499; x=1741214299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jqg6xgss2TwTJnwYTz6WVElRsaDmvCoRkq61/S/VaTA=;
        b=MaLC7jK7230zN8eC/yLVNif84/0qH22mPLjEeOQsqARsVkug0SkVu6ZgpPfkzCmxjl
         3bTjWleXF8+iABRL14w6Jcq+/MfZkCTqvQEzgCLLq5pVLvE9PwSGQiDzmkNLXOOhQdhu
         xxB+Q4hwITu9+m3SrZbpqhDKv1lnT8OVx6lwnzbhjI5Ux+1gQyE3bPwe7/5p9IyYazw8
         PpgxQVubKoXvp3Q94+HzR7C8FK3omrEjGgJq3GgxtnPUg86A6VAYqy/MdoMDZF5jN3KZ
         ibayJzCTlOSbtQoAl6WcALfFxmbShwyV37/4ur1bCJ19kFUTdrCoVNUwghC9HoyuMq4q
         heHw==
X-Forwarded-Encrypted: i=1; AJvYcCUw2ZLAOYiMVAu5UMqtBUCwi0Xj/p6uL429WzFgN5ABeBpTngxPdMMS+7rNAomjoJpVIOqrgJX6wL3h+AA=@vger.kernel.org, AJvYcCWyFG79DM7ieANzzMG8ZKICh/xRovdgPWC/K3jRh5cq9udNkTeh3SwUg0iqZPTYRX8EcIv93snmLdZO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uOxdB6WYxVw1jS+SUu3i6YbJESHK01zwSFrDHQtGg6A4XWgo
	FO2MAzap2TTqS0kAhZGZPkUw+Z9iiQKyUZTFH7P5Vabunh+XxrOgXib3FQ==
X-Gm-Gg: ASbGncuqU9Wz+cQS/4OXyiUm00LTMTrYfmbpMvpJY0pIl8CcjuisDBk0VstNJen7ouN
	DL9Rs1fbCZ8FJyNcMJsDW0G4vioH4y8pnVX3WgU5IkaIOjOBse9Np47odmhd0R2bgDnfCz2Esjo
	WujojeRMyX+cmQCn0G3BCHO9l+jyCQYS7q39DodlZL7/FI6pYZqeIOo3iuepbmxJR5xC3CoxYZU
	1JYlXQSYYSaakHogJRAulC3jhggPEXVL8AblpDvH6knwV11706YdSPVrM8u/ZcUcErO0hvXn560
	94jzM/P6SVmwyqw8drLZ/WjaD9iDhQgA3jc3c2RW
X-Google-Smtp-Source: AGHT+IFvnCcjVzKiyESHJQTcXdKkePyQ5sqIwPDa4LsokuRcrAZowyqutvPh5KZs+5lN8m7DEenuDA==
X-Received: by 2002:a17:906:18b1:b0:abb:ebfe:d5eb with SMTP id a640c23a62f3a-abeeed5bbccmr595868666b.18.1740609498741;
        Wed, 26 Feb 2025 14:38:18 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6f60b2sm14506266b.102.2025.02.26.14.38.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Feb 2025 14:38:18 -0800 (PST)
Date: Wed, 26 Feb 2025 23:38:15 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] usb: xhci: Don't skip on Stopped - Length
 Invalid
Message-ID: <20250226233815.46d2f053@foxbook>
In-Reply-To: <20250226080255.770ca055@foxbook>
References: <20250226080202.7eb5e142@foxbook>
	<20250226080255.770ca055@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 08:02:55 +0100, Michal Pecio wrote:
> After d56b0b2ab142, TDs are immediately skipped when handling those
> Stopped events. This poses a potential problem in case of Stopped -
> Length Invalid, which occurs either on completed TDs (likely already
> given back) or Link and No-Op TRBs. Such event won't be recognized
> as matching any TD (unless it's the rare Link TRB inside a TD) and
> will result in skipping all pending TDs, giving them back possibly
> before they are done, risking isoc data loss and maybe UAF by HW.

Actually, Stopped and Stopped - Short Packet may be unsafe too.
As far as I understand, one of those (depending on SPC capability)
can occur on the second TRB of a TD whose first TRB completed with
Short Packet. Then the TD is already given back and removed from
td_list, so no match will be found with this Stopped event.

I suspect this is the reason why the driver has a policy to silently
ignore Stopped events which don't match the pending TD, and not only
Stopped - Length Invalid. Not sure why Stopped - Short Packet isn't
also ignored and yet apparently doesn't cause problems.

