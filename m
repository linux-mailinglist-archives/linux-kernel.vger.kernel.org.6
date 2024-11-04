Return-Path: <linux-kernel+bounces-394179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF29BAB82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33021F20F03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5C29CE5;
	Mon,  4 Nov 2024 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1iXRmKY4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112AB665
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691280; cv=none; b=sLKk0lxGcj3rJqWvcebrof65m+akh3kTpGad+0pcdoZStRcZPG4mmxPvsK0O8a6pONDPjIqlAL+QDdGn2nbdEXXS2AG5s4WvVufBLqh5vTMUzY2ek+cISldDcWn+2XEj8PmuIto+ePAnxY6qPRWx7h5r94IVCgxN0wefwbOONZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691280; c=relaxed/simple;
	bh=t2Ffegw9XuyvUeuCBs3ABkR4HlPBoKuEGiryrfcn6F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjyWxVSSAFdk1ApPU8MkTpQeECugn9CNui6F9fzvSTBKZLu1bfZPRoGkAl02UT+pUBuylH7elJeL2WG/PitCJCa/rVlQUnLULEg3IRHyl2LH0TJm8X7Y5ImfKWBogj4Upw6Cmp3OWuD4BapT4XTpwqNEDi9b5R8izUOlBePGLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1iXRmKY4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720be27db74so2320728b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 19:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1730691278; x=1731296078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eBbwFrR+dBhY0dHAlBKK9mb7WSbo06+hERUtUnrIe0=;
        b=1iXRmKY4bTZeq3Dz7voQmn4ki8Gq5iGrYiFW9NP0obqplGVd9EciZFCqNgksZ3tySo
         D6CKKAsWaMV3593W4tnvaA6opyiolfFZWtAiUVB+phZ3adqjHG9QjpgGZKfTjapsa97j
         9gbG6KHUINLM/KIyZeaNXCXadPbQDRCIV5wYOJ9ZsCWVA7JMGgAScsYZz/oGH8H1NDNG
         tiXCO2LUOB/7ZHI3lUsOlz67V80FD4Qvf7H4GrgS0do7Tw1W+h+ZVdsuxYKImYbAj64f
         2RVNrbJ4s97pXARSqKrii4WYZhAwkzfCTfpYWa9PH6Yld9DGVbb1v1mA1DJU9N7Qnq8j
         OkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730691278; x=1731296078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eBbwFrR+dBhY0dHAlBKK9mb7WSbo06+hERUtUnrIe0=;
        b=dLO+IZ6NYXrd3LJ9RCM5s+K7TIomdzs8POcFjJ0SO3LlmTko46Rhl4WdfFTfi5Iq2Z
         Y6d7F4TjlIzCFUNZ+BRDc7j17VbrxfBwfKGfmDmmIKZE9YBZhTnwKHfQaG3kcjMkAdNT
         VHDcwzDw+NMrJQenSp/CpS3sdpk1RGyAQkOpUGe7wZTAKU5SHNw+ecdE5X3rCW8qslZC
         aajDTrhgiIkZYmnzgL9wYVLL15vMcV3YOgpYt50BSo9PkDn8jNu2MqCPeLqXYeV8hSyL
         I3KEMJ/N9Sjgq1Xk0ZIA3rXILZscfSsYYasp0Zn3M+xb9+jVw18Esx59J/nuQUqfNU65
         swRg==
X-Forwarded-Encrypted: i=1; AJvYcCV1T76WlDr39S32vr/Bfutnsd62qoVrrGtnjMrycONgneAkth5ImONYeLXZi4EWvCDtXI46q5ZqV+BpwV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTZkTGKDPB4wcIZsQiT5nJpfaYpZEeSzmTbplZOOb6cdRJIgL
	RbzlBWqOviYhAUm82v0XDbefvCVjnAqCjhWDv1m+HLwCE6g1nBcIYv/w/klGIw0=
X-Google-Smtp-Source: AGHT+IE+ZcBwfMfYoe3knIpQuh2XNotXgZx/5/fQz5pg8a266Tcev3FQq8SsEEVe2NwBipVehVrNLA==
X-Received: by 2002:a05:6a00:2342:b0:71e:7f08:492c with SMTP id d2e1a72fcca58-720bcaf1aeemr21169498b3a.1.1730691277887;
        Sun, 03 Nov 2024 19:34:37 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3902sm6327428b3a.136.2024.11.03.19.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 19:34:37 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t7nrO-009sal-1y;
	Mon, 04 Nov 2024 14:34:34 +1100
Date: Mon, 4 Nov 2024 14:34:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: djwong@kernel.org, dchinner@redhat.com, leo.lilong@huawei.com,
	wozizhi@huawei.com, osandov@fb.com, xiang@kernel.org,
	zhangjiachen.jaycee@bytedance.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Subject: Re: [PATCH 0/5] *** Introduce new space allocation algorithm ***
Message-ID: <ZyhAyrateNQPz3Hw@dread.disaster.area>
References: <20241104014439.3786609-1-zhangshida@kylinos.cn>
 <CANubcdWwg3OB_YV4CteC7ZZBaQXOuvFG1oS7uN+TpabS=Z=Z2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANubcdWwg3OB_YV4CteC7ZZBaQXOuvFG1oS7uN+TpabS=Z=Z2Q@mail.gmail.com>

On Mon, Nov 04, 2024 at 09:49:32AM +0800, Stephen Zhang wrote:
> Hi all,
> 
> I just send the scripts to test these series here.

Please include the scripts as in line text like is done for patches
- base64 encoded attachments are not quotable nor readable in
archives.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

