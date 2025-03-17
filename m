Return-Path: <linux-kernel+bounces-564801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391D7A65AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0252E188F7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FB1B6D01;
	Mon, 17 Mar 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="cFZSmUuK"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389D1B21B8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232789; cv=none; b=r2yQrBzliatqeEXNH0Uweyl6mAl0QiIzzFPR3qQCrKb33yHIKpH5i1QLFlTFQxx632FCrBK18erYY0HsUt5XRzM8B6KhDCpDl7Dc3dUevvFdRohfV8Iwrg3UQUCs9ZN76ajNiAETtl5txpWEiJbZxl3SdspzStAA7ice8G93SqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232789; c=relaxed/simple;
	bh=5RRrVErcTRxnKIdxPJslzQPk8A/oK+G3itW7nO7KTa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddqCnKfJUTg7BlNpG2BYLPON7qvBXuURsTLb48VgjFklVCkDA00hjMgesqyMRAZ1HVzvB09sV0Nxf1oo6S/mdv9+zGa+qzWkUYV9RpKlU29nsaAhFvrldEP3SPPXWoS1IjhP3yUiTrJgc3lrxoZu6MMgDiojae3jem+R+liFVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=cFZSmUuK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c24ae82de4so536720985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1742232786; x=1742837586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NZNox6iu8xJBSg/RTYdvnxp/atiz7Hx4e9AIceCd60=;
        b=cFZSmUuK5YOhWwoAdHhsw7091vWGklI5bRhzenAYbhNt0wgxUHpzTTSizas5bilQPp
         +26Pgx/IFs2P44UjprDdwXj1IwuE09llFnlKVytFm3gSp+lFM4CldeaHXfzvAJ/A8o7Q
         2/D4MDQNSgoehBNkqyYn6n8Jq3vMZThpisACt6qtcWR3qv2ot5gWgR5sdRiyOiY052F0
         0oeU0cj2LEFMlvgip7bkXp3yh79QMKl4SVpW4FOf93yuXnGAAtIAzwTlPd0MMnB/0AbP
         86r9oBd9Og5O1b8Zxnxd37aQ/1aZBTn9G7SIMjD9PljYuLFS1Qfwju0gV4d5FsiE1HL1
         jTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232786; x=1742837586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NZNox6iu8xJBSg/RTYdvnxp/atiz7Hx4e9AIceCd60=;
        b=Z6fGmggKp2NeofpOUMECxJ2mg28lfoGr0Jqm6qcdErMzwaFLtl//oERCtqR1Fuc35j
         /YugBwICPj1pI6f3b8S6U7CY+MC84b5RmkjpkeVZCneaQ7DTzanq3QCwWgpVgev4oEhp
         kwfa+Uy8OCrEfZbO2o+vIqfk9qwjy/xv2yiLOBDr5rhJ3HGc9PFR0Cw5ZiLl8qXREInU
         X0BQTKJrJuA3v/HxCjlg8/FMfDuhHmBsl1jpYQcvZ6lMNqsdpn+6FaqJJpe6n30P9dqm
         Zw+Fs+3O1GN2OEk2RAP7vG+cLKQxgqPYZ9sLDpWF/MYCQPiS2p4Hijh9PJ85SlbXH6zO
         Yqow==
X-Forwarded-Encrypted: i=1; AJvYcCUVuN+L4Zsky+jKn37jJ4P61rTM1FLl9OZTLaQgS92nhQMQnhzy1KqE5JTkRtxr1xk9GzE+wqaDqjn7mDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28FjsmbVf0jrf6xbksYeuty1aWLVgR3Rw5XUxchzHv8t9eusN
	aBp+iYoPiQXtTTx5W/J3SrqupD7f/kzW4dHmbQw8mZqnhrNxC6f8/97k2JBTxA==
X-Gm-Gg: ASbGncvEbmLD0LcnPO824oPXxmC0Lhs5S5WmjG/E18dWQLZk5VUDY9tw1HOABNBiA7U
	WniXBmJzSGuUPFvVSKuOxK1IJS6Pjfye9InWkNXzHwqOuz0WU4lYLhAAFL8W90PM5UCo2dOdfLh
	zJqZUGAxx0VepU8GvijVo2ePzIw3h+/xsLm/JpknL+F2HsPBLXNtkMV0wknngYMeAMWoZWOIoMi
	buWTcTnH2u13rn+EPuE45yfFqvqqyqtgBKx4oxthrGEeYnsTEa0D3AfavusCaBSI0jbRnhVgWAt
	0t7aqyYIsiu7hP0PJW6WVGGVYWH9U/i4Knk6HbGTOQmyG8E3ARXIrD9YSaB46oeQpFfBVLFil3+
	u0xj7PGDVhVYLZEcl9Mh14mawE4sgUOpoAbfSgg==
X-Google-Smtp-Source: AGHT+IG5soVxsZ8/xdkXvSGXhKe5y2I7AECvwFBOSDCoSq7VtIdBtSLQPfxwdrL8MgXC+Cu18J24yA==
X-Received: by 2002:a05:620a:4711:b0:7c5:5596:8457 with SMTP id af79cd13be357-7c59b2c5ce6mr62410285a.57.1742232786512;
        Mon, 17 Mar 2025 10:33:06 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9e081sm609931285a.56.2025.03.17.10.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:33:05 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:33:03 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jingjing Xiong <jingjing.xiong@intel.com>,
	Hao Yao <hao.yao@intel.com>, Jim Lai <jim.lai@intel.com>,
	You-Sheng Yang <vicamo.yang@canonical.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/8] RFT/RFC: Import IPU6 ov02e10 sensor driver and
 enable OF usage of it
Message-ID: <685ef286-0694-44c6-85c2-c6c5f51ce6a4@rowland.harvard.edu>
References: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
 <89af0891-3bbe-4964-8d19-205cdab79497@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89af0891-3bbe-4964-8d19-205cdab79497@redhat.com>

On Mon, Mar 17, 2025 at 10:02:41AM +0100, Hans de Goede wrote:
> Bryan, thank you for your work on this.
> 
> Alan, can you give this version of the driver a test run on your laptop?
> 
> Note you need to skip patch 3/8 for now until I've implemented the
> solution for handshake handling in the INT3472 driver. Also you need
> keep the sleep of at least 25 ms after setting the handshake GPIO.

After installing all the patches except for 3/8 (and adjusting some of 
the later ones to account for its lack), I can confirm that the camera 
on my laptop still works.

Is there any particular aspect you want me to test or is basic 
functionality good enough?

Alan

