Return-Path: <linux-kernel+bounces-307164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977096495D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C966C1F235A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822141B3B1C;
	Thu, 29 Aug 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkN0ZfPf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE71B3749
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943746; cv=none; b=CLdHjCaFvebJYkXXnEmWCZJ9VTN/HERD1ujpoczOLKYNK0wsSPsMfSGureuYx1KF0DxeaPCsNxQkVw47G5Sxg84RNwZ+bHz3dKO3TdiijkjONLXBe5EgY5hUUXpitZh9ZDUMCCyqT+pw3Yccn2vAHoGTocDnO9tIwdnYL+JHilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943746; c=relaxed/simple;
	bh=GEZaiWDFK631P0mdzERneiwEQkphONO54D8rmpn8U7M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jETO4U7YehP8cOiktfrd80cFJr2QY45AfHCLJS37QAkBUSj8iUgqQvq67E/DPcvUddCI2BtqM8ebexu4MnX+FVAKuUmrkNMpT2eX1bfYPQCojQhqsgmGeJovuMZNXZRBzvr0tAox/Lux4fCVirJaFM6O1lWncJWn1M6ciBSR4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkN0ZfPf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b8f13f2965so16081707b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943743; x=1725548543; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZFjdHl5ndv6dmHla3qSadBH36kVYzFr068YdbI0Xhc=;
        b=UkN0ZfPfhivQt+dElQp5KI1X+v177mKUylrH3SkPlYK0o9AjO437p5vGHtXl7RhnTN
         UjuPBtTxtBxsMMmDjb0VICTE/RQvKUhgrXSJPnncgDi07lg7kS3Zy/cuxwgBLNOHi9eu
         4R9f+4Jy8woPnvaRBORppW5hFuXrFMr8u4FNuK2tyfKgQb9ce4xgjhVd4kUeFkw7QtLg
         08llz/5Nz3uPGhbbny2QOhRG2SDSFqNmTY+NsGTtInTH3bfH/Tq7cuMCLfXADy15Mknx
         D74zSl+GEXwCD9tmyg11sHUJI9EHVSraZmB5XQTLun6u+mky1J+hZPGn0f1jCWhK84Vj
         iceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943743; x=1725548543;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZFjdHl5ndv6dmHla3qSadBH36kVYzFr068YdbI0Xhc=;
        b=YZwXBhakCAnUgTaB/mbORPg96+whXLKMIA+Ua8mfnwbCPBCkukoAFwJ0oPk+xQ8kRs
         bHFNxMmjVhapJrRe9xvZbu2MwgDIkyA4+oQ1UEg+dY6mmXzMrp7BdC2yPBYrOEs4kpeP
         M+rg40k5nVt7fVniLy4dTSb/4QmiZJtuFyNZ05NomBXEbUnKUaN1txZZGnYP3pK3bSN2
         ZlX6zSjuT+wsMKWxZ9Vu2bvMkeASqkkkyrvVBkssAvFtm3mW0s3mj28CNop7oz3IxPQ3
         10WhwnxsNStwY7z0iNtf4PQ6fYWCY7p/rF6NKtWUDtrEl4UzR86PztgcnEKL1V0qgCTw
         Cq0A==
X-Forwarded-Encrypted: i=1; AJvYcCWS085WCJrdh1Dif84zSNO1yCZVGbZYH85KrSJNp5IMDiuY+LXdC/fgjEmSfscEAsUZIBYVLoKxpfaEBRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMnfI2HrrA/WdDAN/2VHqGxUUEBV589guJ7UoIVrt2UeOlefG
	iV/3bGeDnTgDPTGaXgC/u5xkb1Kito3yfzvU5iI4PssbvB7EK+DoxOmaqovZnuih/kJeSbV3Ikk
	hNfrXmQ==
X-Google-Smtp-Source: AGHT+IEELMgnHZPPq1sGI0nkDr7BeKf8/zF6d4T6auMfStXzWs7I1S1Gxz4SLdE2SrLgnG9r095oYxv3xZYe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a05:690c:6301:b0:68e:8de6:618b with SMTP
 id 00721157ae682-6d2e6f712dcmr1417277b3.2.1724943743131; Thu, 29 Aug 2024
 08:02:23 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:51 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 5/8] perf header: Allow attributes to be written after data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With a file, to write data an offset needs to be known. Typically data
follows the event attributes in a file. However, if processing a pipe
the number of event attributes may not be known. It is convenient in
that case to write the attributes after the data. Expand
perf_session__do_write_header to allow this when the data offset and
size are known.

This approach may be useful for more than just taking a pipe file to
write into a data file, `perf inject --itrace` will reserve and
additional 8kb for attributes, which would be unnecessary if the
attributes were written after the data.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 106 +++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 65c9086610cb..4eb39463067e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3676,32 +3676,50 @@ int perf_header__write_pipe(int fd)
 static int perf_session__do_write_header(struct perf_session *session,
 					 struct evlist *evlist,
 					 int fd, bool at_exit,
-					 struct feat_copier *fc)
+					 struct feat_copier *fc,
+					 bool write_attrs_after_data)
 {
 	struct perf_file_header f_header;
-	struct perf_file_attr   f_attr;
 	struct perf_header *header = &session->header;
 	struct evsel *evsel;
 	struct feat_fd ff = {
 		.fd = fd,
 	};
-	u64 attr_offset;
+	u64 attr_offset = sizeof(f_header), attr_size = 0;
 	int err;
 
-	lseek(fd, sizeof(f_header), SEEK_SET);
+	if (write_attrs_after_data && at_exit) {
+		/*
+		 * Write features at the end of the file first so that
+		 * attributes may come after them.
+		 */
+		if (!header->data_offset && header->data_size) {
+			pr_err("File contains data but offset unknown\n");
+			err = -1;
+			goto err_out;
+		}
+		header->feat_offset = header->data_offset + header->data_size;
+		err = perf_header__adds_write(header, evlist, fd, fc);
+		if (err < 0)
+			goto err_out;
+		attr_offset = lseek(fd, 0, SEEK_CUR);
+	} else {
+		lseek(fd, attr_offset, SEEK_SET);
+	}
 
 	evlist__for_each_entry(session->evlist, evsel) {
-		evsel->id_offset = lseek(fd, 0, SEEK_CUR);
-		err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
-		if (err < 0) {
-			pr_debug("failed to write perf header\n");
-			free(ff.buf);
-			return err;
+		evsel->id_offset = attr_offset;
+		/* Avoid writing at the end of the file until the session is exiting. */
+		if (!write_attrs_after_data || at_exit) {
+			err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
+			if (err < 0) {
+				pr_debug("failed to write perf header\n");
+				goto err_out;
+			}
 		}
+		attr_offset += evsel->core.ids * sizeof(u64);
 	}
 
-	attr_offset = lseek(ff.fd, 0, SEEK_CUR);
-
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
 			/*
@@ -3711,40 +3729,46 @@ static int perf_session__do_write_header(struct perf_session *session,
 			 */
 			evsel->core.attr.size = sizeof(evsel->core.attr);
 		}
-		f_attr = (struct perf_file_attr){
-			.attr = evsel->core.attr,
-			.ids  = {
-				.offset = evsel->id_offset,
-				.size   = evsel->core.ids * sizeof(u64),
+		/* Avoid writing at the end of the file until the session is exiting. */
+		if (!write_attrs_after_data || at_exit) {
+			struct perf_file_attr f_attr = {
+				.attr = evsel->core.attr,
+				.ids  = {
+					.offset = evsel->id_offset,
+					.size   = evsel->core.ids * sizeof(u64),
+				}
+			};
+			err = do_write(&ff, &f_attr, sizeof(f_attr));
+			if (err < 0) {
+				pr_debug("failed to write perf header attribute\n");
+				goto err_out;
 			}
-		};
-		err = do_write(&ff, &f_attr, sizeof(f_attr));
-		if (err < 0) {
-			pr_debug("failed to write perf header attribute\n");
-			free(ff.buf);
-			return err;
 		}
+		attr_size += sizeof(struct perf_file_attr);
 	}
 
-	if (!header->data_offset)
-		header->data_offset = lseek(fd, 0, SEEK_CUR);
+	if (!header->data_offset) {
+		if (write_attrs_after_data)
+			header->data_offset = sizeof(f_header);
+		else
+			header->data_offset = attr_offset + attr_size;
+	}
 	header->feat_offset = header->data_offset + header->data_size;
 
-	if (at_exit) {
+	if (!write_attrs_after_data && at_exit) {
+		/* Write features now feat_offset is known. */
 		err = perf_header__adds_write(header, evlist, fd, fc);
-		if (err < 0) {
-			free(ff.buf);
-			return err;
-		}
+		if (err < 0)
+			goto err_out;
 	}
 
 	f_header = (struct perf_file_header){
 		.magic	   = PERF_MAGIC,
 		.size	   = sizeof(f_header),
-		.attr_size = sizeof(f_attr),
+		.attr_size = sizeof(struct perf_file_attr),
 		.attrs = {
 			.offset = attr_offset,
-			.size   = evlist->core.nr_entries * sizeof(f_attr),
+			.size   = attr_size,
 		},
 		.data = {
 			.offset = header->data_offset,
@@ -3757,21 +3781,24 @@ static int perf_session__do_write_header(struct perf_session *session,
 
 	lseek(fd, 0, SEEK_SET);
 	err = do_write(&ff, &f_header, sizeof(f_header));
-	free(ff.buf);
 	if (err < 0) {
 		pr_debug("failed to write perf header\n");
-		return err;
+		goto err_out;
+	} else {
+		lseek(fd, 0, SEEK_END);
+		err = 0;
 	}
-	lseek(fd, header->data_offset + header->data_size, SEEK_SET);
-
-	return 0;
+err_out:
+	free(ff.buf);
+	return err;
 }
 
 int perf_session__write_header(struct perf_session *session,
 			       struct evlist *evlist,
 			       int fd, bool at_exit)
 {
-	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
+	return perf_session__do_write_header(session, evlist, fd, at_exit, /*fc=*/NULL,
+					     /*write_attrs_after_data=*/false);
 }
 
 size_t perf_session__data_offset(const struct evlist *evlist)
@@ -3793,7 +3820,8 @@ int perf_session__inject_header(struct perf_session *session,
 				int fd,
 				struct feat_copier *fc)
 {
-	return perf_session__do_write_header(session, evlist, fd, true, fc);
+	return perf_session__do_write_header(session, evlist, fd, true, fc,
+					     /*write_attrs_after_data=*/false);
 }
 
 static int perf_header__getbuffer64(struct perf_header *header,
-- 
2.46.0.295.g3b9ea8a38a-goog


