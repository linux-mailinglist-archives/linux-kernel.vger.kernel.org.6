Return-Path: <linux-kernel+bounces-252258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003C9310A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19BE1B227A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D6E185094;
	Mon, 15 Jul 2024 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V9Ljm2kD"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C713A889
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033599; cv=none; b=M+tjuFmS1l7hlaH8N8k3c4UB2OjlI4olQIjqeCf9/XMAQnbFfwXB7fRE7Kg1S63GIERKPY93ShTmYTVoap75bo2PnSvoIHoEtHdYPxFxhzvA4hFojQZW5okPGcHsdicllJ1U8WOYuWHL08rrnn+z/g1amKuR6M4iSmhd+s9sfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033599; c=relaxed/simple;
	bh=PvIHSvHDyCqHlg4FzdOm/9JZDBPadb9yALdKopHDcRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HA3lb0u/xkcUqQL2ZAgoEGOjjW0hvPqnA1ZBBlQNimXNeHIbeYh6AoD/6VqJHCW4S2xOC/uOcU8emnyZ3LMFDKD4tkcTXXnQLXOnNoHHefGUuyGdaPjYUSYbAjwEMn/JoBHgR9hjxTnd+Uf51cLZ2vJ1ryJuR9mYIZLQVI5g2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V9Ljm2kD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36805befd01so1396137f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721033596; x=1721638396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3odnsVgnGxuOUiR7+Vp9cvYXGHiYs1cqaY5JH4bJ45g=;
        b=V9Ljm2kDw/zAUJGXF8rLKqiaVpnAMnK1S5YusyH/MXXGNxwgfUgbkMAznvJR640L5l
         Ap3exzR8BEUsU1JiGBnHfWieq8Nd1K2G3sk+rZu8WyKugnlfRyqvDZyWm874gYcFxj39
         DQYvhl/YKu7j0FgHBnUOvwEfbDeHZfwgINojF1A8dKdtwvxDL0x06n3Q72lPmn1+trmX
         cQgqEJn/TmANEEl77LHuUJ0TBqdSMbe0yImTeUfyo//d5pMuRyDQLon+33FBObZjNi8p
         Dx6QEmq3QkV1+v/TOKrbmEdxVMiwkpZv63/x81D4PUxtigvT0AvadXbT14LvmgZkvgSV
         PLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033596; x=1721638396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3odnsVgnGxuOUiR7+Vp9cvYXGHiYs1cqaY5JH4bJ45g=;
        b=t8EMCXZRzLAbVXmBVnlcOic8kdNWhTBNkOMhlTzFwvQxD7g4kL+F92ZAn5ab3Ai80B
         KGyFnuNvI+VdW1MVaTNqIOAsKNLYaUUJDq8RFOpXDvprihOp5KhdspCOj5aLYd/e1AAV
         0TwJS6/ehMNlMWBpYrDbOh3ycubTJhUHC3xKCUaX4JOGzBVwhKMnX9AdhIBprA5cUtsI
         hlRzmCHgY3dHo4UKiOH7aW5I89r0uativwEv+T60YpjyHmb1H9CLyQlndTlUrJyLFwyK
         K3SvsP0l6PfGbhv9iIBQM5RfGW6VIWLN5ytfk9nWXjN0InCmYRbiJAUX7FD/v1NTfIiv
         dLjw==
X-Forwarded-Encrypted: i=1; AJvYcCX+25KqPHPLfhnZm/e4tLy0QfSLSMwUmXPkTpR6uEHq0E09WiDUIVYVq74ol3Ljj9+zwKPExod9yFDkPZTLqw7PQ+2/PBKRz+0rDb1O
X-Gm-Message-State: AOJu0Yy5i8WXdqZaNV3j6MKL5gKJntq65C70e/pPVxLk14GYXKVfPcdn
	rS28rwlf+5pCG0/ZFiji83uwIYvwVm58H2JRN0y1dZEejpEu61ks2j7BS8lv3YQ=
X-Google-Smtp-Source: AGHT+IGcbA7Mwq7h0WiIhyo8KuepT/D1REFUiK2c6xTrJurCwDRfFLaG/d2cskZbQnaFqO6Qk3d9sw==
X-Received: by 2002:adf:fb0e:0:b0:367:9387:fb14 with SMTP id ffacd0b85a97d-367cea735a4mr12099028f8f.27.1721033595554;
        Mon, 15 Jul 2024 01:53:15 -0700 (PDT)
Received: from ?IPV6:2001:a61:137b:5001:be5a:c750:b487:ff1b? ([2001:a61:137b:5001:be5a:c750:b487:ff1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db047c4sm5711198f8f.108.2024.07.15.01.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:53:15 -0700 (PDT)
Message-ID: <2a80d11d-029f-4e7e-9a8e-3abae1034add@suse.com>
Date: Mon, 15 Jul 2024 10:53:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
To: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>, gregkh@linuxfoundation.org,
 brauner@kernel.org, jlayton@kernel.org, jack@suse.cz,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
 <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <9ef72886-13b8-46cf-a0aa-54dad36102e9@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11.07.24 16:41, Alan Stern wrote:
> On Thu, Jul 11, 2024 at 10:59:56AM +0200, Oliver Neukum wrote:

>> I am sorry, but this implementation has some fundamental issues.
> 
> Agreed, but the solution is pretty simple.  Because the device was
> suspended, the userspace driver must have enabled suspend via the
> USBDEVFS_ALLOW_SUSPEND ioctl.

The whole system could have been suspended, in particularly to S4.

	Regards
		Oliver


