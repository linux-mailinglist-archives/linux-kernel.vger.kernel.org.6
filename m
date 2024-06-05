Return-Path: <linux-kernel+bounces-201637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDFF8FC125
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0D9285313
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C593DDC1;
	Wed,  5 Jun 2024 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCugkmDA"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CED51C;
	Wed,  5 Jun 2024 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550016; cv=none; b=EZr9QnPzIMS8z+EWso0U6s7nmEbwRjjKdoTQZotDBqO659UuYxGLfcEuxF2lt5XRSZvGCCS9hCI38iveQIakUC2g04jd5Apq4KlwzmdKDNkGzd1W6zS/0y0nUWy8CxOPHi7anG0sdsW9k0ruD0s0f3W2gTe3X/GUpnc8H6utwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550016; c=relaxed/simple;
	bh=aeTRylefGuQHaUtMZDE+X7LC3UE9fNWSsaXvqpbrIqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fcutyFI4Vhl3VOi5RfYtIDG94MyeiVRcicCufSxjbQLsATKwSD3KrGcUkxpyx8S6zWqKva2pGFENpf41i1sZGGA/KNZgh8BXj9aRX1U2GmcNwiFRlSKr24cn0nvPjeSIkO/w8AFXcRYbOQyjXkG40KdeHtngPPWdAP5nBgMbUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCugkmDA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f44b594deeso45555925ad.2;
        Tue, 04 Jun 2024 18:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717550014; x=1718154814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu6vsHCnxaPM2f2KKum/zLpiydGYEoGWT465e/02zAo=;
        b=HCugkmDACu0fNsqFfXhekybmI/KjIJSAEHw/NzBhvHHTaXaO9V8CrS9VQXImHe9u0k
         YWP/MZTbhvDArUcoJB71Z1YtnNG/BUW3sChKBd/uBW6Ei0JwbJ3k+eJdOHmy4JmHk6ha
         DiufAr2/VxLtxWjRWAqEr7AdUfS/Tl+YY8PZ5FsqgK2W+0rTPJvxahKNnqZO5vy7O0g/
         mdIgm+WRaUkqWpfcW3XcFsemPtfKhQObHWchRSnUrScRa1ZmkNWEqMl+J9zBzWMylsY9
         jQ/uGYCkDXz7lYXWhKaFhR1Gg416AqbfDspDwGmiyk41HNkkKbymUAXdcbVsEeJJeGK+
         r0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717550014; x=1718154814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tu6vsHCnxaPM2f2KKum/zLpiydGYEoGWT465e/02zAo=;
        b=tRI5vNiihJjQGhqFRkAKusRvNsO62KcR7rvpgn0STts+rLbG+9XCVwLfD0zthxw7AO
         x3wcyirm0cHeAceOJ9qOL6ks491GDZtHDlRlqcgC7LSB60fpQIq/sakJ0MvD2+wb/LXn
         fLa2wLrLC3dXMnjF1mABTMWv9ZFObL+ssxvgSKHfeuku+WYzwR5cwjJa2+qsaXzLxYEi
         S8s9N2xOoy6eWW343cCJmAjmW8L7sqRoiwfb2JSjIoRbP9GVP2cOxAFAh2Qd9JaWnct5
         abErDHYPND065y9ex5qPWIWRE31SVDiXmxaq2UMTL7MoyAqyw/suo7ZlPaYgJniWZedY
         pLvg==
X-Forwarded-Encrypted: i=1; AJvYcCXtqT6Kg1KIjZAwiTMk1gMTE89OPei9nRwUOMoT2RVAvlQASxqvU+XwJ3HonHG6TejjBtPQpTVvjq9PwcJ0XGwSsJSUzULH2Qfq6+9HKatZO6ipIvrCg7x9nVZpP1iRUwD9CHRKpGx1Yi5B3p1KY/su876YDzVFOh92UOISCbSfZI4w
X-Gm-Message-State: AOJu0YzApxl4kkfyCkM/F4cR2mam/8onvbbq/YQWYgBW1KQtzfrf4NhA
	m/ATIuw2RcFcWkN2f5y+1DL79NQ6IMOQnsavRztE8LPOwfsjlXZF
X-Google-Smtp-Source: AGHT+IGJgM+34V9qBDcdXOjRRC6HPnlatgP+2RACljuIkhwsYwWu5xrjOtUVR/Ipe0ykdmx38saDZA==
X-Received: by 2002:a17:902:c94a:b0:1f4:9e69:a8f9 with SMTP id d9443c01a7336-1f6a5a7a27emr13895425ad.62.1717550013931;
        Tue, 04 Jun 2024 18:13:33 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dc75sm89997825ad.8.2024.06.04.18.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 18:13:33 -0700 (PDT)
From: yskelg@gmail.com
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	Jinwoo Park <pmnxis@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH v5] Documentation: cve Korean translation
Date: Wed,  5 Jun 2024 10:08:13 +0900
Message-Id: <20240605010811.19445-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This is a Documentation/process/cve korean version.

The following changes have been updated based on SeongJae Park’s feedback
from the last v4 patch.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 Documentation/translations/ko_KR/index.rst    |   1 +
 .../translations/ko_KR/process/cve.rst        | 107 ++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/translations/ko_KR/process/cve.rst

diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/translations/ko_KR/index.rst
index 4add6b2fe1f2..46cbaf5696f2 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -13,6 +13,7 @@
 
    howto
 
+   process/cve
 
 리눅스 커널 메모리 배리어
 -------------------------
diff --git a/Documentation/translations/ko_KR/process/cve.rst b/Documentation/translations/ko_KR/process/cve.rst
new file mode 100644
index 000000000000..30f2fc0420d8
--- /dev/null
+++ b/Documentation/translations/ko_KR/process/cve.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:원문: Documentation/process/cve.rst
+:역자: 김윤성 <yskelg@gmail.com>
+:감수: 박진우 <pmnxis@gmail.com>, 김동현 <austindh.kim@gmail.com>
+
+==========
+CVE 항목들
+==========
+
+공통 취약점 및 노출(CVE®) 번호는 공개적으로 발표된 보안 취약점을 식별, 정의 및
+목록화하기 위한 명확한 방법으로 개발되었습니다. 시간이 지남에 따라 커널
+프로젝트와 관련하여서는 그 유용성이 감소했으며, CVE 번호는 부적절한 방식과
+부적절한 이유로 할당되는 경우가 매우 많았습니다. 이로 인하여 커널 개발
+커뮤니티에서는 이를 기피하는 경향이 있었습니다. 그러나 커널 커뮤니티 외부의
+개인과 회사가 CVE 및 기타 형태의 보안 식별자를 할당하라는 지속적인 압박과
+지속적인 남용이 결합되면서 커널 커뮤니티가 이러한 할당에 대한 통제권을 가져야
+한다는 것이 분명해졌습니다.
+
+Linux 커널 개발팀은 잠재적인 Linux 커널 보안 문제에 대해 CVE를 할당할 수
+있는 권한이 있습니다. 여기서 할당은
+:doc:`일반 Linux 커널 보안 버그 보고절차</process/security-bugs>`와는
+별개입니다.
+
+Linux 커널에 할당된 모든 CVE 목록은
+https://lore.kernel.org/linux-cve-announce/ 에 있는 Linux-CVE 메일링 리스트의
+아카이브에서 확인할 수 있습니다. 할당된 CVE에 대한 알림을 받으려면 다음 메일링
+리스트를 `구독<https://subspace.kernel.org/subscribing.html>`_ 하세요.
+
+절차
+====
+
+일반적인 안정 릴리스 절차의 일부로, 잠재적으로 보안 문제가 될 수 있는 커널
+변경 사항은 CVE 번호 할당 담당을 하는 개발자가 식별하여 CVE 번호를 자동으로
+할당합니다. 이러한 할당은 linux-cve-announce 메일링 리스트에 공지사항으로
+수시로 게시됩니다.
+
+리눅스 커널은 시스템의 최하단 계층에서 동작합니다. 때문에 거의 모든 버그가
+커널 보안을 취약하게 만들 수 있습니다. 하지만 버그를 수정할 때 악용 가능성을
+명확하게 파악하기 힘든 경우가 많습니다. 이 때문에 CVE 할당 팀은 지나치게
+조심스러워 보일 수도 있는 방식으로 버그 수정이 확인되는 모든 버그에 CVE 번호를
+할당합니다. 이것이 리눅스 커널 팀이 발행한 많은 수의 CVE를 설명합니다.
+
+사용자가 CVE를 지정해야 한다고 생각하는 특정 수정 사항을 CVE 할당 팀이 놓친
+경우에는 <cve@kernel.org>로 이메일을 보내 주시면 커널 CVE 할당 팀에서 함께
+작업할 것입니다. 이 별칭은 이미 릴리스된 커널 트리에 있는 수정 사항에 대한
+CVE 할당 전용이므로 잠재적인 보안 문제는 이 메일 주소로 보내서는 안 됩니다.
+수정되지 않은 보안 문제를 발견했다고 생각되면
+:doc:`일반 Linux 커널 보안 버그 보고 절차</process/security-bugs>`를 따르세요.
+
+Linux 커널에서 수정되지 않은 보안 이슈에 대해서는 CVE가 자동으로 할당되지
+않으며, 수정이 제공되고 stable 커널 트리에 적용된 후에만 자동으로 할당되며,
+기존 수정의 git 커밋 ID로 추적할 수 있습니다. 커밋으로 문제가 해결되기 전에
+CVE를 할당받고자 하는 사람은 커널 CVE 할당 팀<cve@kernel.org>에 문의하여
+예약된 식별자 항목들에서 식별자를 할당받으시기 바랍니다.
+
+현재 Stable/LTS 커널 팀에서 지원하지 않는 커널 버전에서 발견된 문제에 대해서는
+CVE가 할당되지 않습니다. 현재 지원되는 커널 브랜치 목록은
+https://kernel.org/releases.html 에서 확인할 수 있습니다.
+
+CVE 항목들 할당 분쟁
+====================
+
+리눅스 커널 변경 사항에 할당된 CVE에 이의를 제기하거나 수정할 권한은 영향을
+받는 관련 하위 시스템의 관리자에게만 있습니다. 이 원칙은 취약점 보고의 정확성
+및 책임감을 높이기 위해 존재합니다. 하위 시스템에 대한 깊은 전문 지식과 정확한
+이해를 가진 사람만이 보고된 취약점의 유효성과 범위를 효과적으로 판단하고
+적절한 CVE를 지정할 수 있습니다. 지정된 권한 외의 다른 사람이 CVE를 수정 또는
+이의를 제기하려고 시도하면 혼란, 부정확한 보고, 그리고 궁극적으로는 시스템
+손상으로 이어질 수 있습니다.
+
+유효하지 않은 CVE 항목들
+========================
+
+개별 배포판에서만 지원되는 커널 버전의 보안 문제가 발견된 경우, 또는 개별
+배포판에서 더 이상 kernel.org에서 지원하지 않는 커널 버전을 지원하고 있는
+경우라면, 보안 문제가 발생하는 경우에 Linux 커널 CVE 팀에서 CVE를 할당할 수
+없습니다. 변경된 사항을 적용한 개별 Linux 배포판에 직접 요청해야 합니다.
+
+적극적으로 지원되고 있는 커널 버전에 대해 리눅스 커널 CVE 팀 외의 다른 그룹이
+CVE를 할당했다면, 이 CVE는 유효하지 않습니다. CNA 수정 절차를 통해 특정
+배포판에서 적용한 항목을 무효화할 수 있도록 커널 CVE 할당 팀<cve@kernel.org>에
+이메일을 통해 알려주시기 바랍니다.
+
+특정 CVE의 적용 범위
+====================
+
+리눅스 커널은 다양한 방식으로 사용될 수 있으며, 외부 사용자가 커널에 접근하는
+방법도 여러 가지이며, 전혀 접근하지 않을 수도 있습니다. 따라서 특정 CVE의 적용
+범위는 리눅스 사용자가 결정해야 합니다. CVE 할당 팀은 이를 판단해줄 수
+없습니다. 특정 CVE의 적용 범위를 확인하기 위해 우리 팀에 문의하지 않기를
+바랍니다.
+
+또한 소스 트리는 매우 방대하고, 각 시스템은 소스 트리의 일부분만을 사용하기
+때문에 많은 사용자들이 할당된 CVE 중 상당 부분이 자신의 시스템과 관련이 없다는
+사실을 인지해야 합니다.
+
+즉, 우리는 사용자의 사용 사례를 알지 못하며 사용자가 커널의 어떤 부분을
+사용하는지 알 수 없으므로 특정 CVE가 사용자의 시스템과 관련이 있는지 판단할 수
+없습니다.
+
+여태까지 항상 그래왔듯이, 커뮤니티 구성원들의 통합된 테스트를 거친 전체 커널
+변경 사항을 적용하는 것이 좋습니다. 개별적인 부분만 선택하여 적용하는 것을
+권장하지 않습니다. 또한 많은 버그의 경우 전체적인 문제 해결은 단일 변경 사항이
+아니라 여러 수정 사항의 누적을 통해 이루어집니다. 이상적으로는 모든 문제에
+대한 모든 수정 사항에 CVE가 할당되지만, 때로는 누락될 수도 있습니다. 따라서
+CVE가 할당되지 않은 일부 변경 사항도 시스템에 적용하는 것이 중요할 수 있습니다.
-- 
2.34.1


