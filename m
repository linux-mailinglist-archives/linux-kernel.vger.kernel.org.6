Return-Path: <linux-kernel+bounces-285110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A419C950978
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584F1282EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2961A072D;
	Tue, 13 Aug 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoslguCC"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1984D8DA;
	Tue, 13 Aug 2024 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564391; cv=none; b=dmHLs+0+cygWeew4D0DzNRgdGvfhdCIKYkDDMyaaghv55qpGP9Ue50fOXihYt5YMLpr0F2V2HWsQEFpcqYcF4BIgSuaACzuNSllJI9G/VARWFDJYTU39nQYJqGkUvH8ib3ty2XZ99N8Oh7s6OoQhWhKeL4ixAt1o1rwpxarkieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564391; c=relaxed/simple;
	bh=XZXQn0D9qp6oUZpRwEYVBpQ/F9RMTzsJtw4ybppWYSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDQMV+1JAEQ0WNFCGJaOYZTlXxoy6mQiyAGBBqqDt/46pvs3fTJvDfXRpN+9rFC6hKgDK6na+l7oe9vUHbPjb8JRTQVWMWOF08hag4ion5JxAtVjuxSy2EsZ/4LEeta7niA5r408lOI+5k+QSktH+V82GMui+NhCtlrx9XFjk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoslguCC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ff4568676eso54446805ad.0;
        Tue, 13 Aug 2024 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564389; x=1724169189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pdnkA+t5ian2aHHJUDq7NHgKzc+xyESZiLjyrnpwzY=;
        b=MoslguCCioFS4MQyS6qItX1zAaVu7b03JZA1jfkcqu4eitQLDUb+1C8CQ9aSKpKMPt
         9kZ8+Vb3bRcSw3I+rN3P0841ry9dEWLTWc2pFxdQBUd8ZScamfs9Gq/kBasfMekxEj7s
         p8yHLTcSTQ7/5ruxpOWRyzG+sh9Pm2jTZhkgyChynI6KU752Ko0u0jnJVQArO3thnr3B
         VaFUFC+Biswkpa2LBl1iEZma40s28awVzTIlub1sLP4frYdNt8VVyASIgS+188ybLuFC
         OmRRLUXya74nQEsPbt3WOALHbduRuq+Ol1yNIlZN69VJha+yuE7aVAyIBJKavnQxvcXT
         L5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564389; x=1724169189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pdnkA+t5ian2aHHJUDq7NHgKzc+xyESZiLjyrnpwzY=;
        b=ZaFu1+Ary/2Daj3RK5fWZKDBNlKP+yk/MivWIrYy0TTVBYhDiBJCrpW5+U8C23kdHL
         kYZR6gSeDUqt7jjz0R4zgMbH7ZbNSsdCxw1IBB3rvEi6L+FxvzxeFErRFWdsRSM99cw3
         Ca6g8I2tdje+N7ynRIQeG8GPq8JYSEnOx+ET77vFFezVNT6Vy8j/1eTEpd89t1Ve30RO
         knH+3fEN13FUhe/VWvaNZS//AZTG4eGmNK658fxZuaiRLm8UP/vckHULSxr4zlq4/+lj
         mFHZtbbG0XSbJEy/5ObW6kHwP/dgSGGl1kKN/qRxwp1uYV37hXvPiOzQqMhczdRbkjrv
         FKjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5DmGGuLYnShD/Y72uNVZbPWqV7FaZPOFg/+OLQMhwdiBTWznj1m2xGMd54Dq3DdT2foekyShvJaeqQPot/5nQoSscI0QovwKxcPwSSdpuwYs5lMR3L1XsDRAinOAGCR2wIiaQv93DAUA=
X-Gm-Message-State: AOJu0YyfSAHeJ+cn55HetrGmfCeLmz3JLOkAhrMpUnza+J47ImPd1vWr
	Pj0uz8QMTUcQ++aqcmpaJQrRqAEYqc0cn8rBLJ8732N9RJ6oWjsEhkqAIg==
X-Google-Smtp-Source: AGHT+IEtCQFeSKon38N3qam/q9EKML/imFjl8GYLR3a8KJlvFvNMztaiAox20Q+RYCRpWgI/JkELxQ==
X-Received: by 2002:a17:903:2449:b0:200:668f:bfd5 with SMTP id d9443c01a7336-201ca13d746mr49853555ad.21.1723564389002;
        Tue, 13 Aug 2024 08:53:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1bce12sm15219885ad.227.2024.08.13.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:53:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Aug 2024 08:53:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: chipcap2: drop cc2_disable() in the probe and
 return dev_err_probe()
Message-ID: <95a73570-0ea9-4396-866e-ffb6fc8a2ba0@roeck-us.net>
References: <20240813-chipcap2-probe-improvements-v2-1-e9a2932a8a00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-chipcap2-probe-improvements-v2-1-e9a2932a8a00@gmail.com>

On Tue, Aug 13, 2024 at 12:59:53AM +0200, Javier Carrasco wrote:
> There is no need to actively disable a regulator that has not been
> enabled by the driver, which makes the call to cc2_disable() in the
> probe function meaningless, because the probe function never enables
> the device's dedicated regulator.
> 
> Once the call to cc2_disable() is dropped, the error paths can directly
> return dev_err_probe() in all cases.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

