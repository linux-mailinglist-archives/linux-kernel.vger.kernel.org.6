Return-Path: <linux-kernel+bounces-421491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2D29D8C05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C0E16401C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C91B85EC;
	Mon, 25 Nov 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaXWQ3/a"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088638DE1;
	Mon, 25 Nov 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558342; cv=none; b=mMzhNmoHFlexHBzNJgmAELSrKugcPBcbMq47tGwW35VyJhwork0xb6BiiNAddllwD1HunwiU9mUeoN4pm35N/LY+BqE0l7XFat8gLsPSvdAbtIOXnlBfsGQdgTYtIec91zpXfdPq7evafYxgYObs4OX6yQpM31glWVcEJidXoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558342; c=relaxed/simple;
	bh=HZGnN7ZvK9l3vjhc4ka/Nd1jhI6jhPdZF/eYCoBVsFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+qOeRJaLI1AJ+TBMNuBEwr0iREX0jWl+fNruu4f1y6G+hH0OyZj11G3aHPL8cpxz4ayJTw9fPKQXOMe+8GbEbmqOLXMAafOs63FZynLUpoePxkRvpSxyv7RvvwD/lM5f9kIsBl8nkZolYwXfhbGD7JC4KPq2YfRbZ5JRVmgA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaXWQ3/a; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso3756208b3a.3;
        Mon, 25 Nov 2024 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732558341; x=1733163141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HZGnN7ZvK9l3vjhc4ka/Nd1jhI6jhPdZF/eYCoBVsFk=;
        b=HaXWQ3/ab9KqMtTL6VA9/3hdIygqpWkmHez7UuggdYPywrJP7KBdzewn3Sk5nnP8Gl
         xNklT0M/15fwHV4Z6A/bDpoS9RMZVnHRVS8qZnejU5nY+YLiI7tJ/PH1vVycIIYkTdjZ
         S5UWfRHZ3fgBKh0u+KNYG4/lqMsgSSmBnJu7q4OH+ljVAlk+NsB02TZcj0xgLE4EdYTY
         xa63YqrR7FMSFwgDsBC/Eli/MZO9rGx6dFCf5zn8Yi+yjbp7JlCvJ7uXd5WCLEfTrn8q
         fL30azJNU+AjcMtb/kPhZLqoRtTbXc1ggEr49gaOZqWCgumAJVjR/NCpKZ/vLZ7iZuqc
         SvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732558341; x=1733163141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZGnN7ZvK9l3vjhc4ka/Nd1jhI6jhPdZF/eYCoBVsFk=;
        b=LS/52mAUPwuphKNkqYXQ9huq0RmociTwY7k6jDaOgsu21apUALJMcc39yjJhPAW9sv
         asrHH0S5AbHaS3PBx4yZYhKTRj+zffDHJ6UdsIfiHndzLLtBdrfBZijCy+MI1h1vLvvv
         TaTSMIubww/fUkM/mEFTI6BDqBgBLG2tV0yILDYCOr7kKV32Y6So/LUFAmITVqQCp127
         d1H+AueYNCJStXImEzZ7/ATRnbXpHwg8PIaR8ZcVskR/VijX7gZKwJBGGHHK1A4eIbHG
         4aLfkfONEJv8JHU+ESswDG0NbgX0c2sAN9wdTswVQTBWHOJK8T6rZwHzIXw/6VDZf4hn
         r/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVTLYEKpRFXR9n/qqpuLUXIoIuRvGVumbXj12NTwMOD6IpOA36jlTDi7IAXsiREcPoFfdLxvmKdM3P@vger.kernel.org, AJvYcCVkEbS0pJ1gWwoEzvy9eJbakQX4zXWbtG4t+YZ9cWNgJIOP6667SqI+cJvMn/eNBjQxuNrkZRl60Nto/GQ=@vger.kernel.org, AJvYcCWWL9pZseHTL2UBDufhHjZfzz4h91DatRzW412DHAXMaN1D5Y8q6UawMsUZZMQLea5f0jKVEvfw/Jz5@vger.kernel.org, AJvYcCWlaLAOB6STTHochJdrZU2bn4EZ0bNAC7WvUixTmFZRa0N1toegox6Gz1aRGzw9eOQAXLTPn1rQ8+btrx94@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rk/WliNhUujZGFLicEhRYIrvoTu2tb2AHmOiNUIAQO1hs6J0
	IYEHBRgWc7PkwSFZd6QxhQeP2gU6N2NZ+SqN2E7X4O1o84gbwLiY
X-Gm-Gg: ASbGncv0VGsYCu3jMFz9Nj08a7GPjCRnh2bkJsr6fcUbSEz85tb5yBEC6EqNDtmPP/D
	vxEa0MezeU4e9hUQ63BmGQMtycydTGrbXHobICLIJ9LvFiZAKBpEXq5KWLPKOqowxyfxUw5yRdb
	X+dx58n+mtPOkSWoggf7Q6K9kOVxTuZW8LxZ7BmBF6zJGV6WAnFD/9/9c6AUoawTTyCF1ykxVhZ
	al80CWRFLVfQaxrL5yVaR5i+u8UxDMH8Ui54bLqS9yBFgMkqEjiniQXqvcujYZCJupCiYlrMfO/
	lfkGgg4GLDNACrfPRXBooUM=
X-Google-Smtp-Source: AGHT+IEUEbyZ/Kpur7hRBQ4uW7UnROr06ax8gY4d8PF7fVW4aGOa8CMU3yI63lRaIQJqWZUyZD7mHA==
X-Received: by 2002:a05:6a00:92a2:b0:71e:cc7:c507 with SMTP id d2e1a72fcca58-724df6b566emr22723763b3a.23.1732558340583;
        Mon, 25 Nov 2024 10:12:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de5346basm6935817b3a.108.2024.11.25.10.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 10:12:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d8b9adb8-9f04-4c52-a1c5-18c00ccbc627@roeck-us.net>
Date: Mon, 25 Nov 2024 10:12:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LTC2978 HWMON PATCHES
To: "Jones, Michael-A1" <Michael-A1.Jones@analog.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "jdelvare@suse.com" <jdelvare@suse.com>
References: <PH0PR03MB69779A87462D5888E8526E77F62E2@PH0PR03MB6977.namprd03.prod.outlook.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <PH0PR03MB69779A87462D5888E8526E77F62E2@PH0PR03MB6977.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Michael,

On 11/25/24 09:55, Jones, Michael-A1 wrote:

Please do not send patches as attachments, but as patch series.
Note that the devicetree patch should come first. An intro patch
is not necessary, but attachments simply don't work.

Thanks,
Guenter


