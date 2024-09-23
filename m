Return-Path: <linux-kernel+bounces-334192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9653F97D3B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC47289508
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4142A13C682;
	Fri, 20 Sep 2024 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YGxskrwE"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1133985
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824959; cv=none; b=F3vH5wIjrMrun9DFt2VictPin9za+6ZMhL/ycbHuUwkPDQ6tzTjNVy03qEzJeIpiy00BMWtja/0Lq5IkRyGAZJqMmJu22hF5xmkoM+cco8SbW15KVzvdOcYZCEnQdug2AMZL7fvWoHM6SX+Uy1QkabjpniJw8BBgWHLvTB/+0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824959; c=relaxed/simple;
	bh=wOtQsEhhjAhWoZR3qcn1/pQp9HTZYrFhQ9fCpT9g5rE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k5atAoHW1amAd3i8XAPM1F79UBlMOecxflXANjZgsd3oUIbrros7anPNZnRWHYkCGyDA8VZlBgpMsdBiEKwnwYQUFmQuA8ZD7YBcP+kSokRyzmCc+VAWHHzd9bO1HSlCATynlkAuV8uef5QH+WTuc2lHXhOIXUR0zcO32qKTNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YGxskrwE; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726824954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OziaRXhCqEX71q65+JEThFme/Bx7YR5ge7b/UpC9jzk=;
	b=YGxskrwEvc+2P9lMit/+EJm6KNvLs7C9bkLx+EMtn7mfkFPgedB1qsE5WAOP1G5Zu8K4Aa
	QZowI2yuMKnznsAiEgZYIB6XOKZCZjG9ZzB9bElsSzQkXPWolHFtibnu7FH1rEWekVZaFK
	xazfqY1FpuT8s7w/krQkPyr7Rq3Y/EQ=
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,
  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: mark fc as ineligible using an handle in
 ext4_xattr_set()
In-Reply-To: <20240919214730.gza4j3gkrn34tcyn@quack3> (Jan Kara's message of
	"Thu, 19 Sep 2024 23:47:30 +0200")
References: <20240919093848.2330-1-luis.henriques@linux.dev>
	<20240919093848.2330-3-luis.henriques@linux.dev>
	<20240919214730.gza4j3gkrn34tcyn@quack3>
Date: Fri, 20 Sep 2024 10:35:45 +0100
Message-ID: <87msk23bwu.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 19 2024, Jan Kara wrote:

> On Thu 19-09-24 10:38:48, Luis Henriques (SUSE) wrote:
>> Calling ext4_fc_mark_ineligible() with a NULL handle is racy and may res=
ult
>> in a fast-commit being done before the filesystem is effectively marked =
as
>> ineligible.  This patch reduces the risk of this happening in function
>> ext4_xattr_set() by using an handle if one is available.
>>=20
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> One comment below:
>
>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>> index 46ce2f21fef9..dbe4d11cd332 100644
>> --- a/fs/ext4/xattr.c
>> +++ b/fs/ext4/xattr.c
>> @@ -2554,11 +2554,15 @@ ext4_xattr_set(struct inode *inode, int name_ind=
ex, const char *name,
>>  	handle =3D ext4_journal_start(inode, EXT4_HT_XATTR, credits);
>>  	if (IS_ERR(handle)) {
>>  		error =3D PTR_ERR(handle);
>> +		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
>> +					NULL);
>
> So when starting a transaction fails:
>
> a) We have a big problem, the journal is aborted so marking fs ineligible
> is moot.
>
> b) We don't set anything and bail with error to userspace so again marking
> fs as ineligible is pointless.
>
> So there's no need to do anything in this case.

Ah! I spent a good amount of time trying to understand if there was a
point marking it as ineligible in that case, but couldn't reach a clear
conclusion.  That's why I decided to leave it there.  And, hoping to get
some early feedback, that's also why I decided to send these 2 patches
first, because fixing ext4_evict_inode() will require a bit more re-work.
The fix will have to deal with more error paths, and probably the call to
ext4_journal_start() will need to be moved upper in the function.

And, as always, thanks a lot your review, Jan.

Cheers,
--=20
Lu=C3=ADs

> 								Honza
>
>>  	} else {
>>  		int error2;
>>=20=20
>>  		error =3D ext4_xattr_set_handle(handle, inode, name_index, name,
>>  					      value, value_len, flags);
>> +		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
>> +					handle);
>>  		error2 =3D ext4_journal_stop(handle);
>>  		if (error =3D=3D -ENOSPC &&
>>  		    ext4_should_retry_alloc(sb, &retries))
>> @@ -2566,7 +2570,6 @@ ext4_xattr_set(struct inode *inode, int name_index=
, const char *name,
>>  		if (error =3D=3D 0)
>>  			error =3D error2;
>>  	}
>> -	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, NULL);
>>=20=20
>>  	return error;
>>  }
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


