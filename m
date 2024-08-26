Return-Path: <linux-kernel+bounces-302187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866F895FAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E653DB22600
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743A19AD73;
	Mon, 26 Aug 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="y+MJuduu"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F529EAC7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705335; cv=none; b=b+q2pUQcjAs/eMC9WqGcGgp5ZgyD0YAtEOUqKaIN1GD3uRJxnXOly6+l83Sn6JKNk/TXf88VIe2b3mdgbCJNY+NrzDBAlI9GZTkUUSnsTdi0Ly1p80Mwe1D+SJzMFJNbJyN9TXtI4CdsQO2r/NRkCE8x5CIjR0E7ypwNxQUOvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705335; c=relaxed/simple;
	bh=EhuGWj0FdQ6Y5ZHeFjg4yfpc364FW13L+Ifwl2Budao=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hU1lOTTr+l3W7nH1CBWPuE2sZk2XZ1SxiccRTTWuu+rDMud6/ehovLVAW/MQ/1pxMse5qWzpIvjckegagun2UvcGj+lWa5Zb3ITt93OpwqEvICyBmRJ+FgElEfVCg+UHProEA++l6fizwdcg5fIyKpQPpQMOi6j7L8EtGl3eok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=y+MJuduu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5334b61b6beso772788e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724705332; x=1725310132; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXLB9zkEdo/4dH8derdyK4VwB9yZuo2dG39pnlUjD2g=;
        b=y+MJuduubw6VB3t5MJD1bMg9NGEFNj/Qd7gQq8pG7sOrrZunXTrMthphPwW4rpFxRv
         wDHWlPTEvJsKYUuC6dUuP5Q2d4ZGeUhUsn8H+nkY0Y5pnVugXiDGBrgh3mw2v/Kl0YRo
         QmQNld6E1yjHqgYFU/Hgct3s9DHYWX++kUCBNTLVuDDkD9Akw9Zb4JwHX0Wl1n/2iMx/
         x+uqP5LnVzh4jqy85WrVgrI8DrPyE3UYkCZ2DfAYAejtle+5aJlP1PHwyQ/L9Br2c249
         h/IZRLyf6+JHAfHpbwbP0LOrBLCRYg+4sgtU+oJWEf1rfnQE98KqCwK80Und5P15K5sm
         fzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705332; x=1725310132;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXLB9zkEdo/4dH8derdyK4VwB9yZuo2dG39pnlUjD2g=;
        b=mbsYkGFQqPjDq8QqK4a5EJiA/KiY8R1IBBcRPBwjs6dm+Kp+XdPl3p5Ko7moVjfsBG
         9Yc0LkXSFTu4197+3c8O1kgE9kklSgXImtXr1uHDQCk5hmagMs09EuFhRNEnPk3ZXKn+
         7VAjkdPbDRtp0Dp1hHe+0F2tu2qpeZ7BlFB/gfGdbULqdWS6OwI+Sn25UKKbd6jjs25B
         CXcK0ZVeobfBWPtN3BNC7DFaB2wPgoKqIbJhsy5mQQsX3vTlwmGsxZzx3gsUFzX+Evwx
         GSBoXiAodTeFCP1rEk8ns9Q90flHlnAnRi679bhQV/UV/gWQYcwz8F/mjDjUNkSEPzhS
         iwSw==
X-Forwarded-Encrypted: i=1; AJvYcCVkHM55kmSkM7P9gbIbrYCWZfbuRqtbAonNd8Am7BrqMull829dyIF6Yz0BHx6n8R8JqKI738zOSW7tOjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+08IxoPBQEFr+YIfEW4WnwKxZg7tP4hja5CzCQQqq1HzA6TV
	jx69tihlXvgGnb6Gldh8JRge+TUpVbiigXMVoXHrkf6M4VxT6igjk7IyBDjRUg0=
X-Google-Smtp-Source: AGHT+IFh7iDNHL3zLwfm2HC+viRd+9tBqo6FndoMyhmB3E5TI9dHA3hsphEOU6Shuce0HutNHgqW3w==
X-Received: by 2002:a05:6512:b8d:b0:52e:ccf4:c222 with SMTP id 2adb3069b0e04-534387c4d10mr4745357e87.9.1724705331999;
        Mon, 26 Aug 2024 13:48:51 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:8cae:d35d:b93e:b368])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d6b3sm18675766b.105.2024.08.26.13.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2024 13:48:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] affs: Remove unused struct members in affs_root_head
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <202408261307.F7D2AD650@keescook>
Date: Mon, 26 Aug 2024 22:48:40 +0200
Cc: dsterba@suse.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9EB1D6D7-DD1F-433D-BF6D-7DAC53EE4BAF@toblux.com>
References: <20240826142735.64490-2-thorsten.blum@toblux.com>
 <202408261307.F7D2AD650@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 26. Aug 2024, at 22:08, Kees Cook <kees@kernel.org> wrote:
> On Mon, Aug 26, 2024 at 04:27:36PM +0200, Thorsten Blum wrote:
>> Only ptype is actually used. Remove the other struct members.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> fs/affs/amigaffs.h | 6 ------
>> 1 file changed, 6 deletions(-)
>> 
>> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
>> index 1b973a669d23..9b40ae618852 100644
>> --- a/fs/affs/amigaffs.h
>> +++ b/fs/affs/amigaffs.h
>> @@ -49,12 +49,6 @@ struct affs_short_date {
>> 
>> struct affs_root_head {
>> __be32 ptype;
>> - __be32 spare1;
>> - __be32 spare2;
>> - __be32 hash_size;
>> - __be32 spare3;
>> - __be32 checksum;
>> - __be32 hashtable[1];
>> };
> 
> This is removing documentation, in a way. Since I suspect you were
> looking at this due to hashtable, maybe just change that to [] and note
> that it (and the other fields) aren't used, but they're kept around to
> help document the format.

Yes, I was looking at hashtable. I'll submit a v2.

Thanks,
Thorsten

