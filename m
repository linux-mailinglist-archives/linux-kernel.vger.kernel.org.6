Return-Path: <linux-kernel+bounces-329425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F7979124
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21CDBB22565
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF651CF5E7;
	Sat, 14 Sep 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GySm7n59"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939B01805E
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321780; cv=none; b=E5sXrAV1AeF4SPIcYDDMnDDtZDQ81eeBEMr++LhuL266K4dbGok+Burdz+rwBjoViGxjRMScwQluTXv504XGFBmO8xxu6cTX7UspBVTEYKuNFlAkYJcI81u8nxUX4Z3r6P7WwgQePxIXPj5s9+NF0nCpXVmZS3XSw/eygHJRjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321780; c=relaxed/simple;
	bh=bX2M4rq5YHrUxdfSxOFiD5LZGmzLc6SfByktZfjqt0M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HZ8LtkQWTzw7777k8un0NP3TiIG1KIRDHQs+lAIHxCOr9NuZ4RFtfGedJRvZnsmohqYHpptTS0PX+T2MusOxk/ZHQawGRgapwGhKY6yvdM4zMuEapZAHyjqynzgJdiQHPvjt1mtFbwM0Bat+MN3AdW1psr9F/vvg+tvp8b5HvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GySm7n59; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49bc672bb46so987325137.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726321777; x=1726926577; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bX2M4rq5YHrUxdfSxOFiD5LZGmzLc6SfByktZfjqt0M=;
        b=GySm7n59USsrxfsvZpdzuLeEyquYjW18o3sFUnDMyfOYdJv2brPKZvdZqOFSNE/2OZ
         hdreLccJ1MhBgE2S6cg6MGDxw75syIjVoJh8gvUxJUbPT0zCTtDp3brgb6OS1Tuck0+p
         5670Mujx5HnbY38uXiiWUNYX71b/XGYmjzLJx9DfLc0F+FNuS4Idx1UZxtw/JyyPtDrD
         C7oVTGgWiUmvTP9ng4moLJYuCON6bWmzTOYRIOK/ElPfl3qX8fB87FsGGPsEEm19Jiwg
         LKMc6ogKo2Qtc3W76W/TGcBmZnEcMuiXZyd8JmXvg5HR+oZLymoAu1grYBAI4ny0yk+3
         e31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726321777; x=1726926577;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bX2M4rq5YHrUxdfSxOFiD5LZGmzLc6SfByktZfjqt0M=;
        b=UWn5oZpAxT3gJIDNcyxlzUFU7/mzNQ1ULe6SBcQxLqX4CDAasIISToWr2DlQoXr8Li
         8Wn7LaHDDQHOMoPhwlRY+AMizfSs5Gtf2/hoLJmyZZXWi1D0YI3TLVTXF232HHnn0u3s
         uWKrYfgg/e85iiOi2AgsD2+NJhZUfLmMk3BgIIFvQa0uRVicE6JvNHGz4SJ2zCqo5ZRC
         RnFqLAoLJ/iDON1xvOxH5BEQRjQUtciWVzhMG5qDqtazv+ivYhAZ/0Lr4Up34clWkbBx
         WXpgvz7ad/JW0FY3uPBWf4Q8OaYI26bEmsxkkl9/OCrsIMvg2bTdpBe0LmTseTbXknQE
         x+OQ==
X-Gm-Message-State: AOJu0YzWgHH3NwDtFQF99Q76BISc6NzCMm4571hmuay2lJL4QPcgDzmk
	5EQhamvOb23icPNcTMPY7/QwIAo6xM6hUqU/bZqQQbHhyw9IlOCcWCjliMOOpa9UV/duiCOQNqr
	UUrzXKYxPmK0dhD1xJx7PAUSc8K6DH8J5
X-Google-Smtp-Source: AGHT+IGBCrBCiv0mCHrsFOXJ4Ju2M1Zl1ZsCNdnOu+tfxmpBBRNbx1/sHmtm60mCdiUxmbx0p8oPBN8JOEQe7eS6QlM=
X-Received: by 2002:a05:6102:3706:b0:49b:ffc8:f580 with SMTP id
 ada2fe7eead31-49d414714fbmr8360233137.11.1726321777321; Sat, 14 Sep 2024
 06:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Danny Barron <dbarronoss@gmail.com>
Date: Sat, 14 Sep 2024 08:49:26 -0500
Message-ID: <CAAAFRSw3F2VnD=-i7Z1G9exrDE4bru+A1A=i+fsf_DFspDH9ag@mail.gmail.com>
Subject: Issue with MT7921E module
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

My Asrock MB has builtin Wifi using Mediatek MT7922 802.11ax wifi, the
driver that has been automatically loaded is MT7921E.
I noticed that every 3 seconds on 6.10 (though probably it was an
issue before) the journal receives an error 'wpa_supplicant[841]:
wlan0: CTRL-EVENT-SIGNAL-CHANGE above=1 signal=-54 noise=9999
txrate=15000'.
This does not occur on current LTS kernel (6.6.51) in ArchLinux, but
does occur in 6.10 'current'.
My Wifi seemingly continues to perform in either case.
I would be happy to engage with tests if anyone would like, but felt
it would be good to report this (just in case it hasn't been).

