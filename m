Return-Path: <linux-kernel+bounces-209922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B045D903CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E95286D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E217C9F5;
	Tue, 11 Jun 2024 13:18:49 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFCD17C7D7;
	Tue, 11 Jun 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111929; cv=none; b=s7gmckgyhOrLeyOXNp9RfNVoen7y9lXk+GeXhf6IjOaG83zS00xhpogG9reY8A2/a63m+boy5Y9IcccDNQyALRXs4TYsD1Dcc3jvSCir8g+wI/0Yb0H0nb5cz9yRjUHFzPHahb/R17N+hqBJeye7ci8Gisd6qF4a+MTrWdCuSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111929; c=relaxed/simple;
	bh=ES7wp3TjBJU7oN34llmd1uzWuSryLZ3GbtLiVIHQF74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LxZpBhgxMoE2PjnOFqFu2BQwlPsRu9Sy6iPyQi69oOiZhzn6xCdl/Rlzafe0ertnuNPqjp181s9cXM8Gg3TbcY+tT6XZImKSr0JGvy7UAhIqsM8RQs5GXd2dt6dO5gfBK+ZnQvjK3wKn8IaQOKFPJje3Vs4YaWbNYXDWDG6ivaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrAC3maprTmhmLNmyBw--.38643S2;
	Tue, 11 Jun 2024 21:17:31 +0800 (CST)
Received: from pride-poweredge-r740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAX08VnTmhmHdkDAQ--.1929S2;
	Tue, 11 Jun 2024 21:17:28 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Cheng Ziqiu <chengziqiu@hust.edu.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts: add scripts/checktransupdate.py
Date: Tue, 11 Jun 2024 21:17:16 +0800
Message-Id: <20240611131723.53515-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrAC3maprTmhmLNmyBw--.38643S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW8CF4kZFyfAFW5Cr47CFg_yoWxZr1xpa
	45G3WIyr4rAFW7Jr4fJw4UuFy3ArnrJFWjqryIgr93Ar17K34F9FWSk34SvrZrWF1rX34a
	ga4Fyr1jkF17uaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
	0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
	4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFW3Jr1UJwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jDkucUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

The checktransupdate.py script helps track the translation status of
the documentation in different locales, e.g., zh_CN and verify if
these documenation is up-to-date. More specially, it uses `git log`
commit to find the latest english commit from the translation commit
(order by author date) and the latest english commits from HEAD. If
differences occur, report the file and commits that need to be updated.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
---
v1->v2: revise the output format of git commits
        add some description and usage of this script
 scripts/checktransupdate.py | 203 ++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100755 scripts/checktransupdate.py

diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
new file mode 100755
index 000000000000..5a0fc99e3f93
--- /dev/null
+++ b/scripts/checktransupdate.py
@@ -0,0 +1,203 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+This script helps track the translation status of the documentation
+in different locales, e.g., zh_CN. More specially, it uses `git log`
+commit to find the latest english commit from the translation commit
+(order by author date) and the latest english commits from HEAD. If
+differences occur, report the file and commits that need to be updated.
+
+The usage is as follows:
+- ./scripts/checktransupdate.py -l zh_CN
+This will print all the files that need to be updated in the zh_CN locale.
+- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+This will only print the status of the specified file.
+
+The output is something like:
+Documentation/translations/zh_CN/dev-tools/testing-overview.rst (1 commits)
+commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
+"""
+
+import os
+from argparse import ArgumentParser, BooleanOptionalAction
+from datetime import datetime
+
+flag_p_c = False
+flag_p_uf = False
+flag_debug = False
+
+
+def dprint(*args, **kwargs):
+    if flag_debug:
+        print("[DEBUG] ", end="")
+        print(*args, **kwargs)
+
+
+def get_origin_path(file_path):
+    paths = file_path.split("/")
+    tidx = paths.index("translations")
+    opaths = paths[:tidx]
+    opaths += paths[tidx + 2 :]
+    return "/".join(opaths)
+
+
+def get_latest_commit_from(file_path, commit):
+    command = "git log --pretty=format:%H%n%aD%n%cD%n%n%B {} -1 -- {}".format(
+        commit, file_path
+    )
+    dprint(command)
+    pipe = os.popen(command)
+    result = pipe.read()
+    result = result.split("\n")
+    if len(result) <= 1:
+        return None
+
+    dprint("Result: {}".format(result[0]))
+
+    return {
+        "hash": result[0],
+        "author_date": datetime.strptime(result[1], "%a, %d %b %Y %H:%M:%S %z"),
+        "commit_date": datetime.strptime(result[2], "%a, %d %b %Y %H:%M:%S %z"),
+        "message": result[4:],
+    }
+
+
+def get_origin_from_trans(origin_path, t_from_head):
+    o_from_t = get_latest_commit_from(origin_path, t_from_head["hash"])
+    while o_from_t is not None and o_from_t["author_date"] > t_from_head["author_date"]:
+        o_from_t = get_latest_commit_from(origin_path, o_from_t["hash"] + "^")
+    if o_from_t is not None:
+        dprint("tracked origin commit id: {}".format(o_from_t["hash"]))
+    return o_from_t
+
+
+def get_commits_count_between(opath, commit1, commit2):
+    command = "git log --pretty=format:%H {}...{} -- {}".format(commit1, commit2, opath)
+    dprint(command)
+    pipe = os.popen(command)
+    result = pipe.read().split("\n")
+    # filter out empty lines
+    result = list(filter(lambda x: x != "", result))
+    return result
+
+
+def pretty_output(commit):
+    command = "git log --pretty='format:%h (\"%s\")' -1 {}".format(commit)
+    dprint(command)
+    pipe = os.popen(command)
+    return pipe.read()
+
+
+def check_per_file(file_path):
+    opath = get_origin_path(file_path)
+
+    if not os.path.isfile(opath):
+        dprint("Error: Cannot find the origin path for {}".format(file_path))
+        return
+
+    o_from_head = get_latest_commit_from(opath, "HEAD")
+    t_from_head = get_latest_commit_from(file_path, "HEAD")
+
+    if o_from_head is None or t_from_head is None:
+        print("Error: Cannot find the latest commit for {}".format(file_path))
+        return
+
+    o_from_t = get_origin_from_trans(opath, t_from_head)
+
+    if o_from_t is None:
+        print("Error: Cannot find the latest origin commit for {}".format(file_path))
+        return
+
+    if o_from_head["hash"] == o_from_t["hash"]:
+        if flag_p_uf:
+            print("No update needed for {}".format(file_path))
+        return
+    else:
+        print("{}".format(file_path), end="\t")
+        commits = get_commits_count_between(
+            opath, o_from_t["hash"], o_from_head["hash"]
+        )
+        print("({} commits)".format(len(commits)))
+        if flag_p_c:
+            for commit in commits:
+                msg = pretty_output(commit)
+                if "Merge tag" not in msg:
+                    print("commit", msg)
+
+
+def main():
+    script_path = os.path.dirname(os.path.abspath(__file__))
+    linux_path = os.path.join(script_path, "..")
+
+    parser = ArgumentParser(description="Check the translation update")
+    parser.add_argument(
+        "-l",
+        "--locale",
+        help="Locale to check when files are not specified",
+    )
+    parser.add_argument(
+        "--print-commits",
+        action=BooleanOptionalAction,
+        default=True,
+        help="Print commits between the origin and the translation",
+    )
+
+    parser.add_argument(
+        "--print-updated-files",
+        action=BooleanOptionalAction,
+        default=False,
+        help="Print files that do no need to be updated",
+    )
+
+    parser.add_argument(
+        "--debug",
+        action=BooleanOptionalAction,
+        help="Print debug information",
+        default=False,
+    )
+
+    parser.add_argument(
+        "files", nargs="*", help="Files to check, if not specified, check all files"
+    )
+    args = parser.parse_args()
+
+    global flag_p_c, flag_p_uf, flag_debug
+    flag_p_c = args.print_commits
+    flag_p_uf = args.print_updated_files
+    flag_debug = args.debug
+
+    # get files related to linux path
+    files = args.files
+    if len(files) == 0:
+        if args.locale is not None:
+            files = (
+                os.popen(
+                    "find {}/Documentation/translations/{} -type f".format(
+                        linux_path, args.locale
+                    )
+                )
+                .read()
+                .split("\n")
+            )
+        else:
+            files = (
+                os.popen(
+                    "find {}/Documentation/translations -type f".format(linux_path)
+                )
+                .read()
+                .split("\n")
+            )
+
+    files = list(filter(lambda x: x != "", files))
+    files = list(map(lambda x: os.path.relpath(os.path.abspath(x), linux_path), files))
+
+    # cd to linux root directory
+    os.chdir(linux_path)
+
+    for file in files:
+        check_per_file(file)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.39.2


