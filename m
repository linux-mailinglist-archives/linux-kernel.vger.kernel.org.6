Return-Path: <linux-kernel+bounces-522927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E9A3D028
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFFD189B517
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640431C6FF0;
	Thu, 20 Feb 2025 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GPiUUYiw"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FF35958
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023605; cv=none; b=Xs4hy6YO1lTakl1dvidDZXcIttO3LTF9Li/m2vq9Bu9frQ7Z+DSeJHmCAypcvZVoY22DZ4cmXf1guRZqMSLbh2LlY490baY+pFC/LVJ/a+w9K2ERva1XSicRc/9ix64LMfQRXp9l70A05YueJHmKly8QA4cuuWBl0Nrr+9R6iM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023605; c=relaxed/simple;
	bh=dEFS6g2p0Miu+E4j9QfDYRwdTdX8K5mAi/JuSyKmKjs=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=Kuk9CtKiI6FSGT2NGgLgsDzOVtP/d6MjTqcLVBNFUjnhdadHwr8vcXW1vQwjw0qiw0xxJpykn0Ue0mVcsKmGPFHaLdn2i30N5eF587kMd7p6jCKCoo4pIptlFt/ip9Bh7B8U4gRObh0KWDO7z1lSIVAGClcmTSqEs5LZwuxRwVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GPiUUYiw; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740023596; bh=P6SBdApr9g5J3G5HF0QjhMQSLKjnzRs1yiRy35LxMek=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=GPiUUYiwTRioPm7rJ/GrZEjVd3amRl3FskzZj4ts5tRxkOUMojQP3jYi54Zu7yPeq
	 /k4fp+6gHZlL7k1YlX/DzGcBPpFp/qRWlrfpLLkCzjLRq9Z9WBCm6eGlsOVUH+/3Qm
	 YVO7nYH7CejSCqoKetHmrHZbOXG6A0hyRVO3CjBk=
Received: from smtpclient.apple ([2408:8207:18a0:b53f:e516:fb34:5948:11a1])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id C70044B3; Thu, 20 Feb 2025 11:49:48 +0800
X-QQ-mid: xmsmtpt1740023388twa3p02ez
Message-ID: <tencent_A9B852318A21F28D817C2F8209DA9E8EEB08@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnOYm99dvGSd+p3RYR1g48mFpwTCisVbnb/XGewOF1DiI1q62RE/
	 NIZ0mKYOmoOkrIBPeeaeDZ/OvB+K1wE7elEo5GLWwedRDGcPFY7wZQ2dJZLaJKr40zj527zF/EsV
	 6E/V0RANamSGClk3mSoUWY0OJv7cy/Dvqj92xE+h5oBK6Zqw7gYHSbmOihM/mCUOrnX423NHTZSN
	 JMy1mO72NVeQ38AYRJsi/xJNzAvnHeBbbA/VEhJIw3il6s7sZPqY5bdutUz0duDuLtUuYTTDwEzZ
	 C33jKbsoWFJ9zbx3+AFhgE6yIxlc29PpdaCcNRFIXpP5mTta3Fc8mJo0nS2pvXa243it/la9ySck
	 nrHHUtfduEB1bglMAWY4eVvUfMslGctvu9aHGLbdULR7HSWT+8B44Nkh9PnXLhFIeByq/zq5ie2b
	 pk3mfhGmQuph+o3Qq+bqkSrhddTAEcCm1cmC8jXCDOr0t0Z6oL0Wot6tA0+NtysvcnOMYNMf4EM0
	 b96YW57/oQluYLogD5KGyXDDUXo0yVHkzjF6xJcTGMY7oWDz4BRTtYQzIIYJRoVv7tV0dhP0jSXw
	 QOqSPo6KqRW4iyB2cRsfImpTP1Uoy+D+SJsODErp+THzw093Ai5I0B4yzi1fTE5RN/2wJ6sIkbsf
	 eLi3hdae6FmfI5ZG5GepB27grk5l7nWadkg2fFoxya0QLBqzfATYtugP9PgxC299wsGQpFyHgKkq
	 8nJM/NXY38Gma4iZufZn44/p0Sr78uczPiYNhsKBmuFSFoTRlT8dh0guYMLsu3dSlkMCvp1t07vQ
	 o9lzhGGMEG5JxJdW/6JxW2eSepuZw5pUP9fscUOoCkpMbk+Pb4Z7pCxdb7JuLv2a7ABkHt9idKXi
	 b4UrPOY6XFdBEqCIZjjhKGiuB029LItEjgJkbFp+GKNAjhQ2SfHUnHVt8WS681DUsyMb5o+KIQJO
	 2RTREBLou4BG5Mur483gH+s5DieRrsEF4+I4MAJWM=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] perf list: Also append PMU name in verbose mode
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20250219151622.1097289-1-james.clark@linaro.org>
Date: Thu, 20 Feb 2025 11:49:37 +0800
Cc: linux-perf-users@vger.kernel.org,
 irogers@google.com,
 namhyung@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <D769887A-5879-467A-BE51-373FF81988AE@cyyself.name>
References: <20250219151622.1097289-1-james.clark@linaro.org>
To: James Clark <james.clark@linaro.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On 19 Feb 2025, at 23:16, James Clark <james.clark@linaro.org> wrote:
>=20
> When listing in verbose mode, the long description is used but the PMU
> name isn't appended. There doesn't seem to be a reason to exclude it
> when asking for more information, so use the same print block for both
> long and short descriptions.
>=20
> Before:
>  $ perf list -v
>  ...
>  inst_retired
>       [Instruction architecturally executed]
>=20
> After:
>  $ perf list -v
>  ...
>   inst_retired
>       [Instruction architecturally executed. Unit: armv8_cortex_a57]
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> tools/perf/builtin-list.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 9e7fdfcdd7ff..c19826f218a0 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -163,11 +163,10 @@ static void default_print_event(void *ps, const =
char *topic, const char *pmu_nam
> } else
> fputc('\n', fp);
>=20
> - if (long_desc && print_state->long_desc) {
> - fprintf(fp, "%*s", 8, "[");
> - wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> - fprintf(fp, "]\n");
> - } else if (desc && print_state->desc) {
> + if (long_desc && print_state->long_desc)
> + desc =3D long_desc;
> +
> + if (desc && (print_state->desc || print_state->long_desc)) {
> char *desc_with_unit =3D NULL;
> int desc_len =3D -1;
>=20
> --=20
> 2.34.1
>=20
> When listing in verbose mode, the long description is used but the PMU
> name isn't appended. There doesn't seem to be a reason to exclude it
> when asking for more information, so use the same print block for both
> long and short descriptions.
>=20
> Before:
>  $ perf list -v
>  ...
>  inst_retired
>       [Instruction architecturally executed]
>=20
> After:
>  $ perf list -v
>  ...
>   inst_retired
>       [Instruction architecturally executed. Unit: armv8_cortex_a57]
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> tools/perf/builtin-list.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 9e7fdfcdd7ff..c19826f218a0 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -163,11 +163,10 @@ static void default_print_event(void *ps, const =
char *topic, const char *pmu_nam
> } else
> fputc('\n', fp);
>=20
> - if (long_desc && print_state->long_desc) {
> - fprintf(fp, "%*s", 8, "[");
> - wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> - fprintf(fp, "]\n");
> - } else if (desc && print_state->desc) {
> + if (long_desc && print_state->long_desc)
> + desc =3D long_desc;
> +
> + if (desc && (print_state->desc || print_state->long_desc)) {
> char *desc_with_unit =3D NULL;
> int desc_len =3D -1;
>=20
> --=20
> 2.34.1
>=20
> When listing in verbose mode, the long description is used but the PMU
> name isn't appended. There doesn't seem to be a reason to exclude it
> when asking for more information, so use the same print block for both
> long and short descriptions.
>=20
> Before:
>  $ perf list -v
>  ...
>  inst_retired
>       [Instruction architecturally executed]
>=20
> After:
>  $ perf list -v
>  ...
>   inst_retired
>       [Instruction architecturally executed. Unit: armv8_cortex_a57]
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Tested-by: Yangyu Chen <cyy@cyyself.name>

Thanks,
Yangyu Chen


