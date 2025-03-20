Return-Path: <linux-kernel+bounces-569956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84021A6AA20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A077D1890DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA0E1EB1B7;
	Thu, 20 Mar 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fOC0lpNT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645F1E9919
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485359; cv=none; b=WPELq68vcMd1rnH7fahN6TTFmTszJvp1C3pUhxyo//kLoky4WFaeuU+alYUi+en1sGg4XSKjuiG0T+lA27fweYCicSoUoid+Cgc22Hn8MZ/dFZlw6NvH8qKZWwXZZ6FDuYfKCTASbe2eZ1m6rabgySqIw3iMjnp/g4J9e3D70DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485359; c=relaxed/simple;
	bh=J32prBUm6oBZ88b3RAURwzKHHWR9F+LoXAHqBCRBzBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jS7VzNJ1F5ItJCQSieBldFjjd67KEqm0rfWQjILIKsAQVXYwMzJrD6j9vyMOCyJ6vlv1qYG0WKqcZqjkc2uH9vQP01kyoQfxJrXFlHvHHZoTG5pMd2Cg6CTmOIveIvLdMkkhUzcgRdBEIn82ZkRmrt5zEpPyaLVB+iVUJcd4i7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fOC0lpNT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso6726025e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742485355; x=1743090155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzdNEu6y+XONtMGIUQtcG5XKDkgKB41TTl7oxU5xJJg=;
        b=fOC0lpNTZrUXHleugTQhIkfVp5+yJzbR7CcCZBPVLAZAgt4QRGqRKBLKt3zuHpKBeF
         NkAjWYKde5Q47uZ90Qf0srZ3T1wr/jdIPr7PY4mYJ+F0IQv4Wf9Mu2oDj+h38Ytni8aw
         1bmbhSZDkLT5ZHrYXM8EE+jsMpHH9slrHpo/Pd1KsGJc916okrCF8QvGkRKALkuGex4L
         M7T7C3SGVNINQzRDfFM4Yvkqu0EX0s4TAB6Ui0724vUA4Qhj0Hm70az+vFbHE4Hbs1TR
         148wd/MKf5ygXUD+9zfbgDNQpcGssEhlpsVPwT91N/AJGK65nqI0RB4yUSptXQgrpyEy
         8cjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742485355; x=1743090155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzdNEu6y+XONtMGIUQtcG5XKDkgKB41TTl7oxU5xJJg=;
        b=nn8Q8ljXDZllBXzPxlEO5k+dke3oe7p1+hXbWCHqvywjcPeD/fQGXynHM7x6TCSQ8i
         iXpAp3wbfdXbqEMwJeSu+PlxBoGgXK3HK93mRnSRPHFqK6gCZKehRWSzEUZQMPkKBWD/
         xk7Vjpuym+khIyE/40Cf3KmXiYtQHRXaepes5+TjTk8/91DMu1chOvlSt6EIbokbixWP
         rmfJVpsEMy3IZMqWXYDI2yRJdoIlLqkTJ6/W7BrEXRk42qdOfFAUswFk1Xa/h0NV8grz
         sccTdhTmW8c9WZIxuBWm6RqKtH8w0ZQuJclQI9ggntvRj4c5ldi7qcu+me0/O0em0YIy
         jQzg==
X-Forwarded-Encrypted: i=1; AJvYcCVmBs7G+TDe5aZIDKrbE5Y/++HW34m6Nc6CkjoYnI0ko372HE3bXqK83/GP8PC2xATOx6rd4UXz96DGcGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66qZNLCYa6y2j+EKioyag89x+doU9wtZSBymwALLHN3/Srphd
	f29ZooQLQHQqdMAsdAEWSkFlZgntKEZYZaAHJ6m0/tEykg/fzKI5sTD73c0xHZs=
X-Gm-Gg: ASbGnctfZPynle9PLBs3JY0spCvtTjcPtBeAPPnZCr2EfUDC2fK5LyNf6dY1bKHb8iU
	cMgcGvtI62Ft/mU67ahrcMRcxG9tThAWm+vk9Q1Z5wOY3dVfE26zoMG4rTfabb+lbPl1Izi0jC/
	7K4WZBMQTp2Mxj/0+rogqKbnfAmrM8BvLX05ZG8SZvuq7LQ4uKv2cO1+MeNITVxhJYOXly/mOyU
	IA3/X1qdd/hL5fVzvxiisbz3A42WVFpdga7vBVyc67wSXt5syJvti9+n/OfWPkoIEUSedypFL33
	7Re7wWX+spuMpMS/WXK62SLC2g5oL3PwQm4lK1XO9TAdfS4PKomCNH/X9UcGehKyeT4Ve68HhPg
	5FFaIbDlBlX0o36nqYdNCWg==
X-Google-Smtp-Source: AGHT+IFQEufoOY/ocwSQk/juDoom1Vr2/cRMpKfbGJG8KRcBZIE/XUKwxnHaV2M2+UGrtqFY48z25w==
X-Received: by 2002:a05:600c:1f92:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-43d502e338emr69485e9.5.1742485354965;
        Thu, 20 Mar 2025 08:42:34 -0700 (PDT)
Received: from ?IPV6:2001:a61:1348:8f01:d3d3:1b29:8986:519c? ([2001:a61:1348:8f01:d3d3:1b29:8986:519c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd348sm1141335e9.39.2025.03.20.08.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 08:42:34 -0700 (PDT)
Message-ID: <7be81186-2d18-4d0e-8a93-d2dda20b02b2@suse.com>
Date: Thu, 20 Mar 2025 16:42:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in cm109_urb_irq_callback/usb_submit_urb
To: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>
Cc: =?UTF-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kun Hu <huk23@m.fudan.edu.cn>,
 Jiaji Qin <jjtan24@m.fudan.edu.cn>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 syzkaller@googlegroups.com
References: <559eddf1.5c68.195b1d950ef.Coremail.baishuoran@hrbeu.edu.cn>
 <62d91b68-2137-4a3a-a78a-c765402edd35@suse.com>
 <a3f66f2e-a99e-47f2-a3ef-742b6903cc5d@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <a3f66f2e-a99e-47f2-a3ef-742b6903cc5d@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.03.25 15:25, Alan Stern wrote:

> This test must itself be subject to the same race, right?  There needs
> to be some kind of synchronization between the two tasks (i.e., a mutex,
> spinlock, or something similar).

Hi,

there is:

static void cm109_stop_traffic(struct cm109_dev *dev)
{
         dev->shutdown = 1;
         /*
          * Make sure other CPUs see this
          */
         smp_wmb();
                 
         usb_kill_urb(dev->urb_ctl);
         usb_kill_urb(dev->urb_irq);
                 
         cm109_toggle_buzzer_sync(dev, 0);
                 
         dev->shutdown = 0;
         smp_wmb();
}

This driver has a tough job as the two completion
handlers submitted each other's as well as their own
URBs based on the data they get.
That scheme is rather complex, but as far as I can tell correct,
but you need to test that flag everywhere.

	Regards
		Oliver
           

