Return-Path: <linux-kernel+bounces-287063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD1952267
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD659286C14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F23B1BE865;
	Wed, 14 Aug 2024 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="mXU90Bum"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1F13C673
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662118; cv=none; b=NWlyc3U6FfHQ3lZTxk11AgZCPKTu6HQ7AN+47JQyo/SBE+thOYFIOo37brb5gsgyXc6hJuzo5qQC52syKFiYbGGXxbVvtl80loSzgW+cpgVp0Qr6wDYfDaTcDoiYBcNofRhk7VpBPQY8E8P7hdoXnvz5a4EUacJ3+eG7Oqry2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662118; c=relaxed/simple;
	bh=OGaN10n6yL8yh2olEJT2j02nk3OGI5k1CeDbLz9A6lY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pToxd9N0+THyZKhxxXwaO18TfEhwwV0HfiKR4fCQ3MuD+PECiacItGtfHsGKn2XLoPpB8XABl4IPmOS+NiKXjG1XhfOAltpqcbrRQglTdVRnfKuSVa3bg5RmH4cWYU0IvCBZqpC3vRjE7Q7wnAuARssao9fRf/93XAlrMPKRwlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=mXU90Bum; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso829545e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723662114; x=1724266914; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL0MfNsyWr5ex5ADWqEilQYZxPzYLltWt4vErx7eAVA=;
        b=mXU90Bum1GBjNYNADQSUfwPEOyONo4eof05k3mz0H9EyfHdBCydJ6sZ9ThnK+h4Mr9
         tBMAvTM+HUSxLCWC8AazbP9BUU0DTOshp3ywaIY+rcMCWLVgZREmpyVOJSpaSswxXLdh
         3v8JUhxlWHPw1mUf79g0s+nzDpcwHalbtkovIL81XI4htcoBF/tla/z3oU1oHyrQJLMt
         w2yDv0POB0ZkYTurimU69kUwqMAlZ/XqfGKuqaTX1Oe2x0ZLJh0FWbJbZR8FWn2/oAmb
         Dxa97KQGifuxuOv4oMZp3VtyvNjf3IU2n7TYBbYqWl6VULxBf4j0DToOlLrfXLHOPgBy
         2+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723662114; x=1724266914;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL0MfNsyWr5ex5ADWqEilQYZxPzYLltWt4vErx7eAVA=;
        b=hM3CJrcXqqxUD0rfqleZfoV3cKpI5LG0DXTSzlGnYgX4Pxdzy7kAPFrq+m/SLQQ40Y
         +6MJdZoCk57ypjxtfnB8sGtn7KYVfnPqjuQ2htDNTZpkJHUY35WutH94zp8AZzAz3YEP
         GTFAhFoOFVXU11ZeKKRCJtFWgdJWhE/2qEU0iT+dAsiEksBfNyyReCrH7BdycRP6gMQr
         Uk9MFu7uNuCITxOoF2skLqOXTySj42r00TFyk09FzYdUhbt2GZmeneJ/8/OzgY5/gBcL
         6fN1sLWcwvw92uuiNUMNDxxHeQ5lP/buoSmeg8wfswaH4b7c5vsqwU0yK7KpvDU9UgMg
         j+5g==
X-Forwarded-Encrypted: i=1; AJvYcCVONvpJcxDlMAby/U8qlO9X0TX5R1gLAQ6Wfyq84TqQ48dbdXtRFdQ6nHJPRTi8dfSQvoEIjPz0hajvQsl2M+/70E9Ive7ocA0tiChF
X-Gm-Message-State: AOJu0YwjNJsbavJoXv24dqvS8rEfn2JT0GXbSXbXsbO7t8WMltmHOl0F
	WdtUwtcrFgZWk+Sll7bljjF2acP/PnpowUpi/RxBOSI1p6fI/0/bBzpWHMeR6Es=
X-Google-Smtp-Source: AGHT+IGqCvAJVTjive1E+96cmWcaG6s009ggA5VJkUkqqZxz+De6UrkQrzuyZ0ogN7TyUs5uJtlkGA==
X-Received: by 2002:a5d:5e10:0:b0:371:7e04:4ae4 with SMTP id ffacd0b85a97d-3717e044e29mr1105985f8f.43.1723662113823;
        Wed, 14 Aug 2024 12:01:53 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a92:ee01:781e:646c:9101:957e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3100sm13334353f8f.95.2024.08.14.12.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2024 12:01:53 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] btrfs: Annotate structs with __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240814180219.GA2542470@thelio-3990X>
Date: Wed, 14 Aug 2024 21:01:42 +0200
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "clm@fb.com" <clm@fb.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "dsterba@suse.com" <dsterba@suse.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7747116F-BA20-455C-84AF-80D0EAD8B152@toblux.com>
References: <20240812103619.2720-2-thorsten.blum@toblux.com>
 <e7cbec5f-269a-410c-bb5a-e00de15078f6@wdc.com>
 <106F3A42-A7CF-402E-B7F7-05AA506C5B7D@toblux.com>
 <20240814180219.GA2542470@thelio-3990X>
To: Nathan Chancellor <nathan@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 14. Aug 2024, at 20:02, Nathan Chancellor <nathan@kernel.org> wrote:
> On Mon, Aug 12, 2024 at 02:03:44PM +0200, Thorsten Blum wrote:
>> On 12. Aug 2024, at 12:54, Johannes Thumshirn =
<Johannes.Thumshirn@wdc.com> wrote:
>>> On 12.08.24 12:37, Thorsten Blum wrote:
>>>> Add the __counted_by compiler attribute to the flexible array =
member
>>>> stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS =
and
>>>> CONFIG_FORTIFY_SOURCE.
>>>>=20
>>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>>>> ---
>>>> fs/btrfs/volumes.h | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>>>> index 37a09ebb34dd..f28fa318036b 100644
>>>> --- a/fs/btrfs/volumes.h
>>>> +++ b/fs/btrfs/volumes.h
>>>> @@ -551,7 +551,7 @@ struct btrfs_io_context {
>>>>  * stripes[data_stripes + 1]: The Q stripe (only for RAID6).
>>>>  */
>>>>  u64 full_stripe_logical;
>>>> - struct btrfs_io_stripe stripes[];
>>>> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
>>>> };
>>>>=20
>>>> struct btrfs_device_info {
>>>> @@ -591,7 +591,7 @@ struct btrfs_chunk_map {
>>>>  int io_width;
>>>>  int num_stripes;
>>>>  int sub_stripes;
>>>> - struct btrfs_io_stripe stripes[];
>>>> + struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
>>>> };
>>>>=20
>>>> #define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
>>>=20
>>> Looks good to me,
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>=20
>>> Out of curiosity, have you encountered any issues with this patch =
applied?
>>=20
>> I only compile-tested it.
>=20
> This change is now in next-20240814 and I see a UBSAN warning at =
runtime
> as a result because the assignment of ->num_stripes happens after
> accessing ->stripes[] (which breaks one of the requirements for using
> __counted_by [1]), meaning that UBSAN thinks this is a zero sized =
array
> due to bioc being allocated with kzalloc().
>=20
>  [   24.992264] ------------[ cut here ]------------
>  [   25.009196] UBSAN: array-index-out-of-bounds in =
fs/btrfs/volumes.c:6602:11
>  [   25.021963] index 1 is out of range for type 'struct =
btrfs_io_stripe[] __counted_by(num_stripes)' (aka 'struct =
btrfs_io_stripe[]')
>  [   25.036463] CPU: 28 UID: 0 PID: 1171 Comm: systemd-random- Not =
tainted 6.11.0-rc3-next-20240814 #1
>  [   25.048172] Hardware name: ADLINK Ampere Altra Developer =
Platform/Ampere Altra Developer Platform, BIOS TianoCore 2.04.100.11 =
(SYS: 2.06.20220308) 11/06/2
>  [   25.064754] Call trace:
>  [   25.069965]  dump_backtrace+0x114/0x19c
>  [   25.076564]  show_stack+0x28/0x3c
>  [   25.082642]  dump_stack_lvl+0x48/0x94
>  [   25.089068]  __ubsan_handle_out_of_bounds+0x10c/0x184
>  [   25.096883]  btrfs_map_block+0x540/0xb3c
>  [   25.103570]  btrfs_submit_bio+0xf8/0x654
>  [   25.110256]  write_one_eb+0x290/0x444
>  [   25.116682]  btree_write_cache_pages+0x44c/0x5a8
>  [   25.124063]  btree_writepages+0x2c/0x8c
>  [   25.130662]  do_writepages+0x10c/0x34c
>  [   25.137175]  filemap_fdatawrite_wbc+0x84/0xb0
>  [   25.144295]  filemap_fdatawrite_range+0x74/0xac
>  [   25.151589]  btrfs_write_marked_extents+0xa0/0x140
>  [   25.159143]  btrfs_sync_log+0x298/0xa98
>  [   25.165743]  btrfs_sync_file+0x440/0x608
>  [   25.172429]  __arm64_sys_fsync+0x90/0xd4
>  [   25.179115]  invoke_syscall+0x8c/0x11c
>  [   25.185628]  el0_svc_common
>  [   25.191185]  do_el0_svc+0x2c/0x3c
>  [   25.197264]  el0_svc+0x48/0xf0
>  [   25.203083]  el0t_64_sync_handler+0x98/0x108
>  [   25.210118]  el0t_64_sync+0x19c/0x1a0
>  [   25.216552] ---[ end trace ]---
>=20
> The fix might be as simple as something like
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 4a259bdaa21c..0cabc2ebde71 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6561,6 +6561,7 @@ int btrfs_map_block(struct btrfs_fs_info =
*fs_info, enum btrfs_map_op op,
> }
> bioc->map_type =3D map->type;
>=20
> + bioc->num_stripes =3D io_geom.num_stripes;
> /*
> * For RAID56 full map, we need to make sure the stripes[] follows the
> * rule that data stripes are all ordered, then followed with P and Q
> @@ -6621,7 +6622,6 @@ int btrfs_map_block(struct btrfs_fs_info =
*fs_info, enum btrfs_map_op op,
> }
>=20
> *bioc_ret =3D bioc;
> - bioc->num_stripes =3D io_geom.num_stripes;
> bioc->max_errors =3D io_geom.max_errors;
> bioc->mirror_num =3D io_geom.mirror_num;
>=20
>=20
> but I am not sure of the implications of this change on quick glance
> with regards to error handling and such.
>=20
> [1]: =
https://people.kernel.org/gustavoars/how-to-use-the-new-counted_by-attribu=
te-in-c-and-linux
>=20
> Cheers,
> Nathan

My patch should probably be reverted as I somehow missed quite a few
things and need more time to rework this properly.

Sorry about that and thanks for reporting this!=

