Return-Path: <linux-kernel+bounces-564883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F90A65C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28E617E413
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597251D61A4;
	Mon, 17 Mar 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eu6XqQtq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191E1A840A;
	Mon, 17 Mar 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235518; cv=none; b=HZ6aANQ9m8tyDobHqjomdSHqhBixkMuf1jGBEYRl3twt5GS7BGSIys6yR+qIuGJG3686usGbwQE5V79/Az/rCF26hQieHnh0TcHm+PmQP2jfw/qOGnNenpzEJhzpXhD7s6hrZDdEnHz6w7oTxi/BFoxnGR3Q0iLtlDsjx1nPSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235518; c=relaxed/simple;
	bh=xe8KfUjDQPuPFRdZphH1n223KpOBP916LLy0up1lalo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxruUDrEqXqwfCVF1BfYvEGEAVdIN8KOqyG6iIrAXEcMmDS5/4lLw7UwlbhFWZ+ynVjVFUu7DRxXwMzArxJosSqt1mdAfqqf0ka4S0LwKthyZ1XjJS4E4PG5JTvKCqQ2vAdFpuwWZMIEz32dIcSyH8pl6COmGs7KaspNYQwqnIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eu6XqQtq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225a28a511eso79194445ad.1;
        Mon, 17 Mar 2025 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235516; x=1742840316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgNpbdg7rD7CF9kSIM9lsk/9NHqJcrRR1ygV6eL4qas=;
        b=eu6XqQtqJDkCroxt/zQ5BaJIxb/3lgJTm8lBvJ2WwjjMPj+g+0ZXK+WKqlrH8z7jDQ
         sN4SSDwT3o/ayyjKEEe1+BWFoMnCX9qnB9LoBNJNaPO5LnqFVK0V68erjfnEgrv1liJQ
         /wO6dJQmH1rI1aX0ooXg58z1xh/L/eh0Y+IN/r19unYnYxvZeUQ8pUIh0RSPutl66tLF
         46bPXOZE7IjZi4tD+lWxeKxQ5ZBenVwSRBHKCSt/I6kybfmRganc6M9PWhmaZQgOvNeX
         X5XH+Hffxk2/QApRMvJvJ52ICoDw7svKLyHYmY+pnWlguCVQOomC/26BhEnOwKKYuGBi
         5ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235516; x=1742840316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgNpbdg7rD7CF9kSIM9lsk/9NHqJcrRR1ygV6eL4qas=;
        b=Wtbzuh7k2KxEDcJmyf8L85HCP1b/LE+tJR81b+VG5B4udD1Y8dFfSBj/UZqrTMDamx
         d/K++4wiByAtM9yl/iR5fCCqU87zmjREypfE921Z0+0xfnuGE/DFNZmoKExRo43d5lHE
         L370U5zewr6FMrE3mBkJviDKP2JddFbtxRebNy9ZxJGEycZJt3pM38ktuMoNFLiYq+6Y
         o96VyAmlOMJU6Ilsf0k99Dqg+XF3xzXCFaVwDPr8zaUI3yQRs3dHmfcUxzfOHjSjqOG2
         SYCI8UgwUKbdNuYg05gE805KHzuOo9tdG7rl0eQ8zhivQb3yTl5RYwLAgcUOFqUwRhW/
         Yllw==
X-Forwarded-Encrypted: i=1; AJvYcCUS4fddJcvq6ojIoGw/CRT+CJJVlk7d4Tzf0RRSSSayJsuCU9eP7CskUHM32OVjViErZE3cpOeoPh+n@vger.kernel.org, AJvYcCV39c7+yTUaekiGfYbPYPCH+7FurC1OXZyXmSZz1Dec7+szONWoEjlLfTuAhwrPzcL1w2QOMrPbsWUJeiE=@vger.kernel.org, AJvYcCW88R0Nk6WbH4gvF+NfWce5xllwpXKEutKsnyvXb2XHzXLZmsl85K4K2EJNS2lr8fc6eV+gg0xl/6uPfzKp@vger.kernel.org, AJvYcCXKmrP6QTMACEPmihLGxXzzTe3h/LgVeE9MF+5TgQyFcKwqhJ5OfKkKhQm+rN11SpExMjZiH8tXBAFy@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPsYmyASRtwDphth05qqwJfHJnd00QxhXsvr1MEqcISgYRcp6
	Q+EMefJWXLrdquRNlvM5t/fCsTvQOQrpemyCIJQS70NwoL70N/1t
X-Gm-Gg: ASbGncunTN/ZXovPdMt7gO8OZuOGqTxdATHXvZUKocR8+OYDq+BPhsCGQVmJCyZb/yp
	Ram+C0YXrGnSuY+p2OxKic/xoPI5d0n80p9EPodTz8LSPXI6QECOwaq/Nwapa5BngaoJsCzhb4P
	umnNXeTnfmj0qlvGkrEM2cj6NdP65UQSuA9P9PnkgrCstOZyrsanVDemxLuKr0iWfZOptPzF9kx
	Ug9ZYWpp/w8BIWcSIEouC+2BJ0JcZu99Vm7Lyo6uNTxuBcpPJRzi7O316S0CE7myOy9/D48mXea
	ExRgE06HWQ1iM6maZH4BigXKmSobqmTljpPJY7RRjhjGyVRvnDaREcD7WQ==
X-Google-Smtp-Source: AGHT+IGTm75VZ2hy30TxP38ei9rlRlFwYSyU436RH9zJQqc4PBg0T13AsNDzAAAmZh528BMapcIqyA==
X-Received: by 2002:a17:902:cec5:b0:224:abb:92c with SMTP id d9443c01a7336-225e0b19692mr145294115ad.50.1742235516599;
        Mon, 17 Mar 2025 11:18:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3c59sm78537665ad.218.2025.03.17.11.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:18:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 17 Mar 2025 11:18:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Leo Yang <leo.yang.sy0@gmail.com>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Leo-Yang@quantatw.com, corbet@lwn.net,
	Delphine_CC_Chiu@wiwynn.com, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: ti,ina2xx: Add INA233 device
Message-ID: <43b8275e-4961-4329-8c24-0017a3c3513e@roeck-us.net>
References: <20250116085939.1235598-1-leo.yang.sy0@gmail.com>
 <20250116085939.1235598-2-leo.yang.sy0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116085939.1235598-2-leo.yang.sy0@gmail.com>

On Thu, Jan 16, 2025 at 04:59:40PM +0800, Leo Yang wrote:
> Add TI INA233 Current and Power Monitor bindings.
> 
> Signed-off-by: Leo Yang <leo.yang.sy0@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

