Return-Path: <linux-kernel+bounces-253861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382893280A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BC01F23110
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3016019B3E6;
	Tue, 16 Jul 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l6x2064q"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2D4D8A3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139199; cv=none; b=NtKNv0FjWBEDB5ReagWtFGHQGGFKtkW1jFtgpduVnMjH/AoZx0KArL+LRwAMt8zhc/bzSA7c3JGc67XdblvM80fcqylRWWLaqP+8ACxK02zAuJOxeVylnbxdEBqrWF/bVgsBbY6RweopFVm3XwChxZylwGCWy2hFMj8UTy10QGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139199; c=relaxed/simple;
	bh=lMHctMZZgHXALQXjijLLcrYq0EEkBBXuPM2pzUtBsOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yfb1mMQ5B8Oguz+JhdKAYjHHuIC4iuKx6NYRus9aZmCHAWXOMkyubPxGylGr/reJEunC1u2smlVTVeKD8IyVso5hM2MII8HHaHRLI8FNL7YGtyLUsUXbOv4Rd6FnZNx/977kgVMIrIjDwRdXxqMvokO7blh6zwpS/melLLJoNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l6x2064q; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jack@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721139192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMpVo1XbRtxcz118lo+kxvs4FtSr6A+atkLL/getcvY=;
	b=l6x2064qicwAvu7NGcNnyY5KR4wFbwsAWM3QyAjcqxX7aApo1BMUP0lBNGP8tIxS8uxj2w
	tciytTDkOsVhjTZco5kq9XecjlyuiJtIix8LV6wq+tEzJH0Cea94zMzpkTQNksYioyDKCt
	GaPdaKGIZfxGa5lBISjomT2ThR/UPDw=
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: tytso@mit.edu
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ext4: fix fast commit inode enqueueing during a full
 journal commit
In-Reply-To: <20240716102416.jublpma3qiltlrbr@quack3> (Jan Kara's message of
	"Tue, 16 Jul 2024 12:24:16 +0200")
References: <20240711083520.6751-1-luis.henriques@linux.dev>
	<20240716102416.jublpma3qiltlrbr@quack3>
Date: Tue, 16 Jul 2024 15:13:05 +0100
Message-ID: <87bk2xtoge.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 16 2024, Jan Kara wrote:

> On Thu 11-07-24 09:35:20, Luis Henriques (SUSE) wrote:
>> When a full journal commit is on-going, any fast commit has to be enqueu=
ed
>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueue=
ing
>> is done only once, i.e. if an inode is already queued in a previous fast
>> commit entry it won't be enqueued again.  However, if a full commit star=
ts
>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs=
 to
>> be done into FC_Q_STAGING.  And this is not being done in function
>> ext4_fc_track_template().
>>=20
>> This patch fixes the issue by re-enqueuing an inode into the STAGING que=
ue
>> during the fast commit clean-up callback if it has a tid (i_sync_tid)
>> greater than the one being handled.  The STAGING queue will then be spli=
ced
>> back into MAIN.
>>=20
>> This bug was found using fstest generic/047.  This test creates several =
32k
>> bytes files, sync'ing each of them after it's creation, and then shutting
>> down the filesystem.  Some data may be loss in this operation; for examp=
le a
>> file may have it's size truncated to zero.
>>=20
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> ...
>
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index 3926a05eceee..facbc8dbbaa2 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal, i=
nt full, tid_t tid)
>>  				       EXT4_STATE_FC_COMMITTING);
>>  		if (tid_geq(tid, iter->i_sync_tid))
>>  			ext4_fc_reset_inode(&iter->vfs_inode);
>> +		} else if (tid) {
>> +			/*
>> +			 * If the tid is valid (i.e. non-zero) re-enqueue the
>> +			 * inode into STAGING, which will then be splice back
>> +			 * into MAIN
>> +			 */
>> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
>> +				      &sbi->s_fc_q[FC_Q_STAGING]);
>> +		}
>
> I don't think this is going to work (even if we fix the tid 0 being speci=
al
> assumption). With this there would be a race like:
>
> Task 1					Task2
> modify inode I
> ext4_fc_commit()
>   jbd2_fc_begin_commit()
>   commits changes
>   jbd2_fc_end_commit()
>     __jbd2_fc_end_commit(journal, 0, false)
>       jbd2_journal_unlock_updates(journal)
> 					jbd2_journal_start()
> 					modify inode I
> 					...
> 					ext4_mark_iloc_dirty()
> 					  ext4_fc_track_inode()
> 					    ext4_fc_track_template()
> 					      - doesn't add inode anywhere
> 					      because i_fc_list is not empty
>       ext4_fc_cleanup(journal, 0, 0)
>         removes inode I from i_fc_list =3D> next fastcommit will not prop=
erly
> flush it.
>
> To avoid this race I think we could move the
> journal->j_fc_cleanup_callback() call to happen before we call
> jbd2_journal_unlock_updates(). Then we are sure that inode cannot be
> modified (journal is locked) until we are done processing the fastcommit
> lists when doing fastcommit. Hence your patch could then be changed like:
>
> +		} else if (full) {
> +			/*
> +			 * We are called after a full commit, inode has been
> +			 * modified while the commit was running. Re-enqueue
> +			 * the inode into STAGING, which will then be splice
> +			 * back into MAIN. This cannot happen during
> +			 * fastcommit because the journal is locked all the
> +			 * time in that case (and tid doesn't increase so
> +			 * tid check above isn't reliable).
> +			 */
> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
> +				      &sbi->s_fc_q[FC_Q_STAGING]);
> +		}
>
> Later, Harshad's patches change the code to use EXT4_STATE_FC_COMMITTING
> for protecting inodes during fastcommit and that will also deal with these
> races without having to keep the whole journal locked.

OK, this looks like it should fix all the issues I was trying to fix
(g/047, g/472, and a few others Ted pointed out).  I'll go run a few more
tests on this to try to catch any possible regression.

Once again, thanks a lot for your help, Jan.

Cheers,
--=20
Lu=C3=ADs

