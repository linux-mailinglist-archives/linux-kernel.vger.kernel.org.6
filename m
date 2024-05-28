Return-Path: <linux-kernel+bounces-192692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA58D20C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A34B224E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35474171E4F;
	Tue, 28 May 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RLYIeefX"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F155171E4C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911454; cv=none; b=RJXao0/2RZwEC5c0IAGJ0Q9e8KnHM1F12vP5FkR9xyhfq70R4Zb/q90CHrcVM7Y+j0xxwlz49ufhJ7JjPquOOs1vMeBN5QZkNjxeiRQloRW9tvLRP4Mojx0eAer0UjJg35F0hSPW9M1gXMb+Pi4c/Yh3+9pf3qzqBBg1UhSrpNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911454; c=relaxed/simple;
	bh=QCCMDxpdmJ+srgqywqKCWhGFPSusYKrZAD6qhc9yhyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pe1XFCO41YqyXCsqcS2RrXYoO5B9f6JUuS6ad2eYj0lQJVNC+cC3KOxqaq6M+cMcL/N15DiGi/iF3lYQvpuwuRV2bYNGwkDrXIYixuggIMRak0iznAJZe+09kvAsJ/zLwIjJeIQbjRUw0IdPyVSy2eXnaCjifIyLVi5hlmUpuTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RLYIeefX; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: adilger@dilger.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716911450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHw2YJhhZmTOU02aflNpxbKBHH+JQUb3QTzxIAA3pg4=;
	b=RLYIeefXzu93uk+UJH1H3eS6ySKm/EMygmtiKO6KHE3y40ACtD0AGJBzMKAtFIlVu9ALcS
	upZIlPlc1+dPRNBgKopt1kx6uMTF6O7DCLj8WaDXVj9AbcEwWrmg95kAyNrPg9Gr4qa80B
	GiLZwZo9Dbi6aoN8jnCL5XzjVaAKodc=
X-Envelope-To: tytso@mit.edu
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,
  Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix fast commit inode enqueueing during a full
 journal commit
In-Reply-To: <20240528105203.2q4gxqz6amgvud4l@quack3> (Jan Kara's message of
	"Tue, 28 May 2024 12:52:03 +0200")
References: <20240523111618.17012-1-luis.henriques@linux.dev>
	<20240524162231.l5r4niz7awjgfju6@quack3> <87h6ej64jv.fsf@brahms.olymp>
	<87msob45o7.fsf@brahms.olymp> <20240528103602.akx2gui5ownj25l3@quack3>
	<20240528105203.2q4gxqz6amgvud4l@quack3>
Date: Tue, 28 May 2024 16:50:46 +0100
Message-ID: <87h6eirl49.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue 28 May 2024 12:52:03 PM +02, Jan Kara wrote;

> On Tue 28-05-24 12:36:02, Jan Kara wrote:
>> On Mon 27-05-24 16:48:24, Luis Henriques wrote:
>> > On Mon 27 May 2024 09:29:40 AM +01, Luis Henriques wrote;
>> > >>> +	/*
>> > >>> +	 * Used to flag an inode as part of the next fast commit; will be
>> > >>> +	 * reset during fast commit clean-up
>> > >>> +	 */
>> > >>> +	tid_t i_fc_next;
>> > >>> +
>> > >>
>> > >> Do we really need new tid in the inode? I'd be kind of hoping we co=
uld use
>> > >> EXT4_I(inode)->i_sync_tid for this - I can see we even already set =
it in
>> > >> ext4_fc_track_template() and used for similar comparisons in fast c=
ommit
>> > >> code.
>> > >
>> > > Ah, true.  It looks like it could be used indeed.  We'll still need =
a flag
>> > > here, but a simple bool should be enough for that.
>> >=20
>> > After looking again at the code, I'm not 100% sure that this is actual=
ly
>> > doable.  For example, if I replace the above by
>> >=20
>> > 	bool i_fc_next;
>> >=20
>> > and set to to 'true' below:
>
> Forgot to comment on this one: I don't think you even need 'bool i_fc_nex=
t'
> - simply whenever i_sync_tid is greater than committing transaction's tid,
> you move the inode to FC_Q_STAGING list in ext4_fc_cleanup().

Yeah, I got that from your other comment in the previous email.  And that
means the actual fix will be a pretty small patch (almost a one-liner).

I'm running some more tests on v3, I'll probably send it later today or
tomorrow.  Thanks a lot for your review (and patience), Jan.

Cheers,
--=20
Lu=C3=ADs

