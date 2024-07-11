Return-Path: <linux-kernel+bounces-249774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A492EFA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA91F22E78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A3516EBED;
	Thu, 11 Jul 2024 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="c3IfwJ4N"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5516EB4B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726111; cv=none; b=KCf1DHylnHa9eqw7V92qM0qdNSqkHZ0/V/j6jt9JuOLwMOdLEbYNgjiRwwKNvNjAbLP0VqG3W7/M+4Ejekr1mcFEy+eQ8VLyy+a/Jksq6YxUQrrIEbNXEDj8jtIwuDY1EFlTAxv8s0eHBcvHPIdrrH8qVjoAdvn9gmLILwk71GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726111; c=relaxed/simple;
	bh=6D9bzOEft/5hOiTyAMEWOotgp4ar0MIEplwc1hRjebI=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=LjKXGx9LRdldtxeHpDefZbhdKuzS9fdodfO1I3q0vdQwQcvp58YjgPUUIVxSXB88YAwTTB4XeZK4F6YJrpXiwlvIMX8dB5hc1Ek7QcQ66/o8FT5kR0kEiybQFN7YmZj8OEKlIAU/jm0YXNPl9BzdXW6XoEwhgjhpMXKFflfuxMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=c3IfwJ4N; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b5117ae06so1019269b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1720726107; x=1721330907; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xX1348kpbj/rzzCRaa2X/uIVxdI/0a5u6R7yX/SWYg4=;
        b=c3IfwJ4NvisuDRDZmIsnbNoW1ntZr4H8r4AHQkpl4bLGYbT4wQUTavwVCZjMFTWWD2
         ILvmg20q/5Pai7NPxUl4uziEFrpLRMX2LW1vZ7RuJGa0Sw5yfG14dA1KoZgi4wQ1TLRL
         Aorz0eK/A+I7ryU42bA8yGhRhhpx8+yLIlnjMjJM/Bnn+MUsm9TpKGp0er+Kh734/Vn5
         z7PvRjgCckXd3YkDOYTBA1HBAlTB7lu/wmchyV0ty3uoUcL68g2zVOK+qHKkMSrIKUgH
         hhHhQnCUrzfRo0lb190iRqWxEkqEPg9PIYN++Trjco1zXDWz6nfNS95t4epAx1VvkzWV
         LU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726107; x=1721330907;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xX1348kpbj/rzzCRaa2X/uIVxdI/0a5u6R7yX/SWYg4=;
        b=WPzUp6tPnhYlug6ySSelaHIiABGiIXr3TKZprA47AWys7EzSirM8BFYC06oujehr9H
         smVX1R0hLayvuW2tH3ZgK2M6GXZS9ngFEmj+XylF4eUNq3EhtJV0YjyjrS+uBtanO9px
         p7mU2YjP49q0hYj7DzLA/zE9fDfV1DpHxahDvnRsP2bNHxMF2VzKRSPd+yTJoWNF1PMv
         UtG9fMbAUMbXQlMoxb+7tSwaDrPKwX62jxCK3VtONDhsQ5h7OJNmNBaYYq2GcyYEqpQf
         4GFDh0+dfZqaVSW9z3jf3SCABgrktcL2coeqiaQX5OWquXsM/qoKEYoM3qDdxUw1JabN
         mhQA==
X-Forwarded-Encrypted: i=1; AJvYcCU37otM8rtn4DnvEHXRD0Vg16UlgI4l2z+yY2LJRYWygw+mwAfzYOqLMunwYiJz0axanNA7txxg/HRX/ZEe4m8FGcYc9wxQ6viCQzdY
X-Gm-Message-State: AOJu0YxcjerhqRiXmiUXTdKq3CDl21D8BoTtVoNQ7C6cKoiN3bxhAefW
	GrD6UB/OqVC9C4Nea+q6ou7rn4QLa8f52VJdhB8PCe5Cf3WKsI1jwxS+UBFAqy8=
X-Google-Smtp-Source: AGHT+IGdN1D1e9zNUrcWyK3K5i61xVgwn4bgNzDB6AwAfXnf73WMJB7yjSZosqQkgIlYplHILEM/Hw==
X-Received: by 2002:a05:6a00:928a:b0:70b:970:5046 with SMTP id d2e1a72fcca58-70b43611671mr12588419b3a.29.1720726107098;
        Thu, 11 Jul 2024 12:28:27 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60117c34sm4764560a12.23.2024.07.11.12.28.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:28:26 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <A90C7898-B704-4B2A-BFE6-4A32050763F0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2BE9C842-3F5C-4B34-B3ED-79C21F95D8D4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4] ext4: fix fast commit inode enqueueing during a full
 journal commit
Date: Thu, 11 Jul 2024 13:28:23 -0600
In-Reply-To: <tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
Cc: Luis Henriques <luis.henriques@linux.dev>,
 "wangjianjian (C)" <wangjianjian3@huawei.com>,
 Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.cz>,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Wang Jianjian <wangjianjian0@foxmail.com>
References: <20240711083520.6751-1-luis.henriques@linux.dev>
 <4f9d5881-11e6-4064-ab69-ca6ef81582b3@huawei.com>
 <878qy8nem5.fsf@brahms.olymp>
 <tencent_CF3DC37BEB2026CB2F68408A2B62314E0C08@qq.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_2BE9C842-3F5C-4B34-B3ED-79C21F95D8D4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 11, 2024, at 10:16 AM, Wang Jianjian <wangjianjian0@foxmail.com> =
wrote:
> On 2024/7/11 23:16, Luis Henriques wrote:
>> On Thu, Jul 11 2024, wangjianjian (C) wrote:
>>=20
>>> On 2024/7/11 16:35, Luis Henriques (SUSE) wrote:
>>>> When a full journal commit is on-going, any fast commit has to be =
enqueued
>>>> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This =
enqueueing
>>>> is done only once, i.e. if an inode is already queued in a previous =
fast
>>>> commit entry it won't be enqueued again.  However, if a full commit =
starts
>>>> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit =
needs to
>>>> be done into FC_Q_STAGING.  And this is not being done in function
>>>> ext4_fc_track_template().
>>>> This patch fixes the issue by re-enqueuing an inode into the =
STAGING queue
>>>> during the fast commit clean-up callback if it has a tid =
(i_sync_tid)
>>>> greater than the one being handled.  The STAGING queue will then be =
spliced
>>>> back into MAIN.
>>>> This bug was found using fstest generic/047.  This test creates =
several 32k
>>>> bytes files, sync'ing each of them after it's creation, and then =
shutting
>>>> down the filesystem.  Some data may be loss in this operation; for =
example a
>>>> file may have it's size truncated to zero.
>>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>>> ---
>>>> Hi!
>>>> v4 of this patch enqueues the inode into STAGING *only* if the =
current tid
>>>> is non-zero.  It will be zero when doing an fc commit, and this =
would mean
>>>> to always re-enqueue the inode.  This fixes the regressions caught =
by Ted
>>>> in v3 with fstests generic/472 generic/496 generic/643.
>>>> Also, since 2nd patch of v3 has already been merged, I've rebased =
this patch
>>>> to be applied on top of it.
>>>>   fs/ext4/fast_commit.c | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>>>> index 3926a05eceee..facbc8dbbaa2 100644
>>>> --- a/fs/ext4/fast_commit.c
>>>> +++ b/fs/ext4/fast_commit.c
>>>> @@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t =
*journal, int full, tid_t tid)
>>>>   				       EXT4_STATE_FC_COMMITTING);
>>>>   		if (tid_geq(tid, iter->i_sync_tid))
>>>>   			ext4_fc_reset_inode(&iter->vfs_inode);
>>>> +		} else if (tid) {
>>>> +			/*
>>>> +			 * If the tid is valid (i.e. non-zero) =
re-enqueue the
>>> one quick question about tid, if one disk is using long time and its =
tid   get
>>> wrapped to 0, is it a valid seq? I don't find code handling this =
situation.
>> Hmm... OK.  So, to answer to your question, the 'tid' is expected to =
wrap.
>> That's why we use:
>>=20
>> 	if (tid_geq(tid, iter->i_sync_tid))
> Yes, I know this.
>>=20
>> instead of:
>>=20
>> 	if (tid >=3D iter->i_sync_tid)
>>=20
>> (The second patch in v3 actually fixed a few places where the tid_*()
>> helpers weren't being used.)
>>=20
>> But your question shows me that my patch is wrong as '0' may actually =
be a
>> valid 'tid' value.
>=20
> Actually my question is,  there are some place use '0' to check if a =
transaction is valid, e.g.
>=20
> In ext4_wait_for_tail_page_commit()
>=20
> 5218         while (1) {
> 5219                 struct folio *folio =3D =
filemap_lock_folio(inode->i_mapping,
> 5220                                       inode->i_size >> =
PAGE_SHIFT);
> 5221                 if (IS_ERR(folio))
> 5222                         return;
> 5223                 ret =3D __ext4_journalled_invalidate_folio(folio, =
offset,
> 5224 folio_size(folio) - offset);
> 5225                 folio_unlock(folio);
> 5226                 folio_put(folio);
> 5227                 if (ret !=3D -EBUSY)
> 5228                         return;
> 5229                 commit_tid =3D 0;
> 5230                 read_lock(&journal->j_state_lock);
> 5231                 if (journal->j_committing_transaction)
> 5232                         commit_tid =3D =
journal->j_committing_transaction->t_tid;
> 5233                 read_unlock(&journal->j_state_lock);
> 5234                 if (commit_tid)
> 5235                         jbd2_log_wait_commit(journal, =
commit_tid);
> 5236         }
> 5237  We only wait commit if tid is not zero.
>=20
> And in __jbd2_log_wait_for_space()
>=20
> 79                 if (space_left < nblocks) {
>  80                         int chkpt =3D =
journal->j_checkpoint_transactions !=3D NULL;
>  81                         tid_t tid =3D 0;
>  82
>  83                         if (journal->j_committing_transaction)
>  84                                 tid =3D =
journal->j_committing_transaction->t_tid;
>  85 spin_unlock(&journal->j_list_lock);
>  86 write_unlock(&journal->j_state_lock);
>  87                         if (chkpt) {
>  88 jbd2_log_do_checkpoint(journal);
>  89                         } else if =
(jbd2_cleanup_journal_tail(journal) =3D=3D 0) {
>  90                                 /* We were able to recover space; =
yay! */
>  91                                 ;
>  92                         } else if (tid) {
>  93                                 /*
>  94                                  * =
jbd2_journal_commit_transaction() may want
>  95                                  * to take the checkpoint_mutex if =
JBD2_FLUSHED
>  96                                  * is set.  So we need to =
temporarily drop it.
>  97                                  */
>  98 mutex_unlock(&journal->j_checkpoint_mutex);
>  99                                 jbd2_log_wait_commit(journal, =
tid);
> 100 write_lock(&journal->j_state_lock);
> 101                                 continue;
> We also only wait commit if tid is not zero.
>=20
> Does it mean all these have bugs if '0' is a valid 'tid' ?
>=20
> But on the other hand, if we don't consider sync and fsync, and =
default commit interval is 5s,
>=20
> time of tid wrap to 0 is nearly 680 years. However, we can run =
sync/fsync to make tid to increase
>=20
> more quickly in real world ?

The simple solution is that "0" is not a valid sequence.  It looks like
this is a bug in jbd2_get_transaction() where it is incrementing the =
TID:

        transaction->t_tid =3D journal->j_transaction_sequence++;

it should add a check to handle the wrap-around:

        if (unlikely(transaction->t_tid =3D=3D 0))
                transaction->t_tid =3D =
journal->j_transaction_sequence++;

Cheers, Andreas






--Apple-Mail=_2BE9C842-3F5C-4B34-B3ED-79C21F95D8D4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmaQMlcACgkQcqXauRfM
H+DRjRAAprc6LVSLVShptMqLDt+asLyEF2tTU+AOGJ/tGLKQvOQElKlovr+6VqVe
X7YjGkQmFeruB63ZbP0oQqS9T9ECO5COQGqek+G3lS6NFlewBb1NREk+0ec9t/dS
fGt4ZNYeswMRUIJD5ETRrAenmNKkjRDxS31GX1rXApFLhRePDxH1rmitfX+zE+sU
JBqi35YOUT8/kcIopBp9Oj6NDdbA48lJ287PfnbjijeL426HtlnmSlxbHFzGr4+c
WFJ7DA8Ve11PcBBMFPF96vJFoXU/sjotKjqKqwd4geaZ2lwEIu+++k23lca5m0ra
EUfFcLAIyAhYob15ChrIebOA3D1Lc0Gldu9g11obwUNPr/jTi0xABQaKMa5q2MPv
r4eLWIbMf+TbsKSkxjKpZpMiQ89qmlcl4y4jPIOnky89HtQYxIvmmYxKbkAKiIMN
oOdwa+xi1GzvHt0C1pLn7p0e1Px551SiIIzV4b3HlcHvtl33oMVVZwslFUkMOSWy
QHpwFdopcZONeEMddr3J8fPYBlK4RimRknUK/Ph9S5IKzM5fLebnF+haR8fDkD6D
9TKJOVmSLHPdgeXzP29cCZx7oukt6G/xIOluDyRn+RWm1aV/hnBrARYSb73RQD1n
a8iX2J+/77GPfc85CFYXBv9Hl0U4jvdZjXNh4mGduCXBzMnHw/E=
=Rynx
-----END PGP SIGNATURE-----

--Apple-Mail=_2BE9C842-3F5C-4B34-B3ED-79C21F95D8D4--

